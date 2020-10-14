Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2211528EA67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgJOBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJOBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:44:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB97C0613BB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:05:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A9F23F5; Wed, 14 Oct 2020 18:05:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A9F23F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602713102;
        bh=GTn+yadzJFoFYHH2T+88M3xEIN+AdrMxt2mWDknLRh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfbU/WYo0n7ho5e5BphS3HR2JwtWnCl00zZCy8nQlXd9C6BxUeQO7JXTDdhPy1PGl
         V5bk+QWWEgRlTekpN2zkk/XDgWNv8zkIRbufyOM7iIFRfbFCsphzF3SWCsTUTgjKN6
         D1TTC9mrT29jXJW/R5ugqJSWCN1Xkz1PPpnKS7Bk=
Date:   Wed, 14 Oct 2020 18:05:02 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Message-ID: <20201014220502.GD23262@fieldses.org>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
 <20201009135554.GE15719@fieldses.org>
 <878scfrwls.fsf@nanos.tec.linutronix.de>
 <20201012211308.GH26571@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012211308.GH26571@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:13:08PM -0400, J. Bruce Fields wrote:
> On Fri, Oct 09, 2020 at 10:08:15PM +0200, Thomas Gleixner wrote:
> > In fact the whole thing can be simplified. You can just use time in
> > nanoseconds retrieved via ktime_get_coarse_boottime() which does not
> > read the clocksource and advances once per tick and does not contain a
> > divison and is definitely faster than seconds_since_boot()
> > 
> > The expiry time is initialized via get_expiry() which does:
> > 
> >    getboottime64(&boot);
> >    return rv - boot.tv_sec; 
> > 
> > The expiry value 'rv' which is read out of the buffer is wall time in
> > seconds. So all you need is are function which convert real to boottime
> > and vice versa. That's trivial to implement and again faster than
> > getboottime64(). Something like this:
> > 
> > ktime_t ktime_real_to_boot(ktime_t real)
> > {
> >         struct timekeeper *tk = &tk_core.timekeeper;
> >         ktime_t mono = ktime_sub(real, tk->offs_real);
> >               
> >         return ktime_add(mono, tk->offs_boot);
> > }
> > 
> > so the above becomes:
> > 
> >    return ktime_real_to_boot(rv * NSEC_PER_SEC);
> > 
> > which is still faster than a division.
> > 
> > The nanoseconds value after converting back to wall clock will need a
> > division to get seconds since the epoch, but that's not an issue because
> > that backward conversion already has one today.
> > 
> > You'd obviously need to fixup CACHE_NEW_EXPIRY and the other place which
> > add's '1' to the expiry value and some janitoring of function names and
> > variable types, but no real big surgery AFAICT.
> 
> I'll give it a shot.

I took your code above verbatim, but should I really be following the
example of ktime_mono_to_any()?  (With the seqlock, and maybe also the
more general prototype in case someone needs the other conversions.)--b.

commit eae2005cb432
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Wed Oct 14 10:19:59 2020 -0400

    sunrpc: simplify cache expiry times
    
    We've been rolling our own conversion between wallclock and boot time in
    get_expiry() and convert_to_wallclock().  Thomas Gleixner suggests it
    would be simpler to use nanoseconds since boot stored in time_t
    internally, and create common helpers for the conversion in
    kernel/time/timekeeping.c.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 10891b70fc7b..10868e74d6e2 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -45,8 +45,8 @@
  */
 struct cache_head {
 	struct hlist_node	cache_list;
-	time64_t	expiry_time;	/* After time time, don't use the data */
-	time64_t	last_refresh;   /* If CACHE_PENDING, this is when upcall was
+	ktime_t		expiry_time;	/* After time time, don't use the data */
+	ktime_t		last_refresh;   /* If CACHE_PENDING, this is when upcall was
 					 * sent, else this is when update was
 					 * received, though it is alway set to
 					 * be *after* ->flush_time.
@@ -59,7 +59,8 @@ struct cache_head {
 #define	CACHE_PENDING	2	/* An upcall has been sent but no reply received yet*/
 #define	CACHE_CLEANED	3	/* Entry has been cleaned from cache */
 
-#define	CACHE_NEW_EXPIRY 120	/* keep new things pending confirmation for 120 seconds */
+#define	CACHE_NEW_EXPIRY (120*NSEC_PER_SEC)
+		/* keep new things pending confirmation for 120 seconds */
 
 struct cache_detail {
 	struct module *		owner;
@@ -102,7 +103,7 @@ struct cache_detail {
 							 * than this.
 							 */
 	struct list_head	others;
-	time64_t		nextcheck;
+	ktime_t			nextcheck;
 	int			entries;
 
 	/* fields for communication over channel */
@@ -159,11 +160,9 @@ static inline time64_t seconds_since_boot(void)
 	return ktime_get_real_seconds() - boot.tv_sec;
 }
 
-static inline time64_t convert_to_wallclock(time64_t sinceboot)
+static inline time64_t convert_to_wallclock(ktime_t sinceboot)
 {
-	struct timespec64 boot;
-	getboottime64(&boot);
-	return boot.tv_sec + sinceboot;
+	return ktime_boot_to_real(sinceboot) / NSEC_PER_SEC;
 }
 
 extern const struct file_operations cache_file_operations_pipefs;
@@ -298,17 +297,15 @@ static inline int get_time(char **bpp, time64_t *time)
 	return 0;
 }
 
-static inline time64_t get_expiry(char **bpp)
+static inline ktime_t get_expiry(char **bpp)
 {
 	time64_t rv;
-	struct timespec64 boot;
 
 	if (get_time(bpp, &rv))
 		return 0;
 	if (rv < 0)
 		return 0;
-	getboottime64(&boot);
-	return rv - boot.tv_sec;
+	return ktime_real_to_boot(rv * NSEC_PER_SEC);
 }
 
 #endif /*  _LINUX_SUNRPC_CACHE_H_ */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index d5471d6fa778..07f2b8436e48 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -68,6 +68,8 @@ extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
+extern ktime_t ktime_real_to_boot(ktime_t real);
+extern ktime_t ktime_boot_to_real(ktime_t real);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f388a83f..52d24ffc229f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -851,6 +851,28 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 }
 EXPORT_SYMBOL_GPL(ktime_mono_to_any);
 
+/**
+ * ktime_real_to_boot() - convert real time to boot time
+ * @real:	time to conver.
+ */
+ktime_t ktime_real_to_boot(ktime_t real)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t mono = ktime_sub(real, tk->offs_real);
+
+	return ktime_add(mono, tk->offs_boot);
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_boot);
+
+ktime_t ktime_boot_to_real(ktime_t boot)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t mono = ktime_sub(boot, tk->offs_boot);
+
+	return ktime_add(mono, tk->offs_real);
+}
+EXPORT_SYMBOL_GPL(ktime_boot_to_real);
+
 /**
  * ktime_get_raw - Returns the raw monotonic time in ktime_t format
  */
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 2990a7ab9e2a..4041a483d5b2 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -42,7 +42,7 @@ static void cache_revisit_request(struct cache_head *item);
 
 static void cache_init(struct cache_head *h, struct cache_detail *detail)
 {
-	time64_t now = seconds_since_boot();
+	ktime_t now = ktime_get_coarse_boottime();
 	INIT_HLIST_NODE(&h->cache_list);
 	h->flags = 0;
 	kref_init(&h->ref);
@@ -156,10 +156,10 @@ EXPORT_SYMBOL_GPL(sunrpc_cache_lookup_rcu);
 
 static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch);
 
-static void cache_fresh_locked(struct cache_head *head, time64_t expiry,
+static void cache_fresh_locked(struct cache_head *head, ktime_t expiry,
 			       struct cache_detail *detail)
 {
-	time64_t now = seconds_since_boot();
+	ktime_t now = ktime_get_coarse_boottime();
 	if (now <= detail->flush_time)
 		/* ensure it isn't immediately treated as expired */
 		now = detail->flush_time + 1;
@@ -297,7 +297,7 @@ int cache_check(struct cache_detail *detail,
 		    struct cache_head *h, struct cache_req *rqstp)
 {
 	int rv;
-	time64_t refresh_age, age;
+	ktime_t refresh_age, age;
 
 	/* First decide return status as best we can */
 	rv = cache_is_valid(h);
@@ -470,7 +470,8 @@ static int cache_clean(void)
 		head = &current_detail->hash_table[current_index];
 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
 			if (current_detail->nextcheck > ch->expiry_time)
-				current_detail->nextcheck = ch->expiry_time+1;
+				current_detail->nextcheck = ch->expiry_time
+					+ NSEC_PER_SEC;
 			if (!cache_is_expired(current_detail, ch))
 				continue;
 
@@ -1515,7 +1516,7 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 {
 	char tbuf[20];
 	char *ep;
-	time64_t now;
+	ktime_t now;
 
 	if (*ppos || count > sizeof(tbuf)-1)
 		return -EINVAL;
@@ -1530,10 +1531,10 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 	 * Making use of the number leads to races.
 	 */
 
-	now = seconds_since_boot();
+	now = ktime_get_coarse_boottime();
 	/* Always flush everything, so behave like cache_purge()
 	 * Do this by advancing flush_time to the current time,
-	 * or by one second if it has already reached the current time.
+	 * or by one if it has already reached the current time.
 	 * Newly added cache entries will always have ->last_refresh greater
 	 * that ->flush_time, so they don't get flushed prematurely.
 	 */
