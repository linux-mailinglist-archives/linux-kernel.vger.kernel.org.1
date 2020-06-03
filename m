Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975361ED0A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 09:19:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFCNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:19:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053DIL4A074907;
        Wed, 3 Jun 2020 13:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=vJVzFUNPiejU1nwqO/Bey5L0ZMoE0Xak08Mt948kHyE=;
 b=LeB0e7TiNBWyj/htzuSmAUE6T8ZbLagHICmU64QfpoDtaLfNy+qwWvTCFDfW4v0mrO/Z
 iglZkKWEMi3CaFH94RSv78DOEpe636k8rja+NMMraKgMZTF4GyGdAtRrfPKVPDz+YHMo
 kUM4VYbopLt/tuFJ1p+38apSEyAG9rsZKqrNtW3ZfDJ6A3c4++tf5INeXUGRTsXcHEEu
 klzeiq6tuCJ4LcCkfTo1mTG99JuQ/3Is1wdyw3so4ChY4LLsBuJx0H9ESNfYgXCFG4wj
 iw62ZCDyLeeO6qwtSN5Mb1k19JTzx7p4W8DMcX98vmE7tAvd+7TVK9LK0E8vQFaA7HEK oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31dkrup9hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 13:19:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053DI3sS127831;
        Wed, 3 Jun 2020 13:19:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju37wwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 13:19:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053DItwl025765;
        Wed, 3 Jun 2020 13:18:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 06:18:54 -0700
Date:   Wed, 3 Jun 2020 16:18:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org, Joe Perches <joe@perches.com>,
        Allison Randal <allison@lohutok.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Cross <ccross@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error
 message
Message-ID: <20200603131841.GB22511@kadam>
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
 <87imgai394.fsf@mpe.ellerman.id.au>
 <a3c158fa-3829-f38a-9202-8984b5ef5f21@web.de>
 <87a71liucy.fsf@mpe.ellerman.id.au>
 <20200602114158.GB30374@kadam>
 <87tuzsgz2p.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tuzsgz2p.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 09:37:18PM +1000, Michael Ellerman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > On Tue, Jun 02, 2020 at 09:23:57PM +1000, Michael Ellerman wrote:
> >> Markus Elfring <Markus.Elfring@web.de> writes:
> >> >>>> Please just remove the message instead, it's a tiny allocation that's
> >> >>>> unlikely to ever fail, and the caller will print an error anyway.
> >> >>>
> >> >>> How do you think about to take another look at a previous update suggestion
> >> >>> like the following?
> >> >>>
> >> >>> powerpc/nvram: Delete three error messages for a failed memory allocation
> >> >>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> >> >>> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> >> >>> https://lore.kernel.org/patchwork/patch/752720/
> >> >>> https://lkml.org/lkml/2017/1/19/537
> >> >>
> >> >> That deleted the messages from nvram_scan_partitions(), but neither of
> >> >> the callers of nvram_scan_paritions() check its return value or print
> >> >> anything if it fails. So removing those messages would make those
> >> >> failures silent which is not what we want.
> >> >
> >> > * How do you think about information like the following?
> >> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=f359287765c04711ff54fbd11645271d8e5ff763#n883
> >> > “…
> >> > These generic allocation functions all emit a stack dump on failure when used
> >> > without __GFP_NOWARN so there is no use in emitting an additional failure
> >> > message when NULL is returned.
> >> > …”
> >> 
> >> Are you sure that's actually true?
> >> 
> >> A quick look around in slub.c leads me to:
> >> 
> >> slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
> >> {
> >> #ifdef CONFIG_SLUB_DEBUG
> >
> > You first have to enable EXPERT mode before you can disable SLUB_DEBUG.
> 
> I see ~175 defconfigs with CONFIG_EXPERT=y, so that's not really a high
> bar unfortunately.
> 
> And there's 38 defconfigs with SLUB_DEBUG=n.
> 
> So for kernels built with those defconfigs that documentation is plain
> wrong and misleading.
> 
> And then there's SLOB which doesn't dump stack anywhere AFAICS.
> 
> In fact slab_out_of_memory() doesn't emit a stack dump either, it just
> prints a bunch of slab related info!
> 
> > So that hopefully means you *really* want to save memory.  It doesn't
> > make sense to add a bunch of memory wasting printks when the users want
> > to go to extra lengths to conserve memory.
> 
> I agree that in many cases those printks are just a waste of space in
> the source and the binary and should be removed.
> 
> But I dislike being told "these generic allocation functions all emit a
> stack dump" only to find out that actually they don't, they print some
> other debug info, and depending on config settings they actually don't
> print _anything_.

Wait...  It *does* print a stack trace.  We must but looking at the
wrong function.  Huh...  The stack trace comes from warn_alloc().  What
happen is this:

mm/slub.c
  2673  
  2674          freelist = new_slab_objects(s, gfpflags, node, &c);
  2675  
  2676          if (unlikely(!freelist)) {
  2677                  slab_out_of_memory(s, gfpflags, node);
  2678                  return NULL;
  2679          }
  2680  

The new_slab_objects() will call allocate_slab() which calls
__alloc_pages_slowpath() which calls warn_alloc() on failure.

There are some error paths from alloc_pages() which look like they
could return without the stack dump, but those are impossible paths from
kmalloc or error injection.

regards,
dan carpenter

