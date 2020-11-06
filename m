Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD52A94AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKFKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:50:25 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:34498 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:50:25 -0500
X-Greylist: delayed 1489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 05:50:23 EST
Received: from host-92-5-241-147.as43234.net ([92.5.241.147] helo=[192.168.1.13])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kayvz-00071a-Sl; Fri, 06 Nov 2020 10:25:31 +0000
Subject: Re: [linux-safety] [PATCH] taskstats: remove unneeded dead assignment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
From:   Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <6ab2415b-0642-16ee-4be0-c909e07e7565@codethink.co.uk>
Date:   Fri, 6 Nov 2020 10:25:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 06/11/2020 06:22, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
>   [clang-analyzer-deadcode.DeadStores]
>           rc = 0;
>           ^
> 
> Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> send_cpu_listeners") made send_cpu_listeners() not return a value and
> hence, the rc variable remained only to be used within the loop where
> it is always assigned before read and it does not need any other
> initialisation.
> 
> So, simply remove this unneeded dead initializing assignment.

Might be better to remove 'rc' completely as it is only used for the if
condition now.

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2802b6ff4bb..63541f1ae04a 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -113,11 +113,10 @@ static void send_cpu_listeners(struct sk_buff *skb,
        struct listener *s, *tmp;
        struct sk_buff *skb_next, *skb_cur = skb;
        void *reply = genlmsg_data(genlhdr);
-       int rc, delcount = 0;
+       int delcount = 0;

        genlmsg_end(skb, reply);

-       rc = 0;
        down_read(&listeners->sem);
        list_for_each_entry(s, &listeners->list, list) {
                skb_next = NULL;
@@ -126,8 +125,8 @@ static void send_cpu_listeners(struct sk_buff *skb,
                        if (!skb_next)
                                break;
                }
-               rc = genlmsg_unicast(&init_net, skb_cur, s->pid);
-               if (rc == -ECONNREFUSED) {
+               if (genlmsg_unicast(&init_net, skb_cur, s->pid) ==
+                   -ECONNREFUSED) {
                        s->valid = 0;
                        delcount++;
                }




-- 
Regards
Sudip
