Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172832B1FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgKMQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:13:42 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:52788 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgKMQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:13:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0D394837F24A;
        Fri, 13 Nov 2020 16:13:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2525:2560:2563:2682:2685:2828:2859:2901:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6117:6119:7208:7464:7904:8784:8957:9025:9113:9121:9163:9165:9391:10004:10394:10400:10848:11026:11232:11233:11658:11876:11914:11984:12043:12050:12114:12266:12295:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:13870:13904:14181:14659:14721:14777:21063:21067:21080:21347:21433:21451:21611:21627:21789:30003:30029:30054:30055:30056:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: owl98_140d4ca27310
X-Filterd-Recvd-Size: 2867
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 16:13:37 +0000 (UTC)
Message-ID: <97b1b575659bc87a07a308765769451d9eee4aef.camel@perches.com>
Subject: Re: [mm] b6efe2fcc4: BUG:kernel_NULL_pointer_dereference,address
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        lkp@lists.01.org, ltp@lists.linux.it
Date:   Fri, 13 Nov 2020 08:13:36 -0800
In-Reply-To: <20201113121025.GA7578@xsang-OptiPlex-9020>
References: <20201113121025.GA7578@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 20:10 +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: b6efe2fcc4e11010710ef5cd8e2bcbeb221a06c6 ("mm: slub: Convert sysfs sprintf family to sysfs_emit/sysfs_emit_at")
> url: https://github.com/0day-ci/linux/commits/Joe-Perches/mm-Convert-sysfs-sprintf-family-to-sysfs_emit/20201102-041456
[] 
> on test machine: 8 threads Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> [   41.689368] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [   41.696354] #PF: supervisor read access in kernel mode
> [   41.701508] #PF: error_code(0x0000) - not-present page
> [   41.706661] PGD 0 P4D 0 
> [   41.709205] Oops: 0000 [#1] SMP PTI
> [   41.712702] CPU: 3 PID: 4619 Comm: read_all Tainted: G          I       5.10.0-rc1-00005-gb6efe2fcc4e1 #1
> [   41.722296] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
> [   41.729714] RIP: 0010:slabs_cpu_partial_show+0x95/0xe0

Right, thanks.

I mistakenly dropped a test for page below:

@@ -5156,44 +5156,45 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
                page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
-               if (page && len < PAGE_SIZE - 20)
-                       len += sprintf(buf + len, " C%d=%d(%d)", cpu,
-                               page->pobjects, page->pages);
+               len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
+                                    cpu, page->pobjects, page->pages);
        }

I'll correct it and resubmit.


