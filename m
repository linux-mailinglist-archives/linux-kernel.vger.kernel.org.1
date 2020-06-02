Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB51EBA9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 07:43:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52208 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:43:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052BgP1L091422;
        Tue, 2 Jun 2020 11:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=Kk9wT92u0WcfVRusnM3tWt4dIWc2ZjNaQZcGKV4NkrI=;
 b=YeZh12ah1IqOhrfvMRf2PDsUY4CY70Y0YvzwBaL2jfNMGJJjxx9KaNYUsKAgCT4tLPCB
 nslne7JzAKOkOw5KZlIEnhXioGQr7+2FhYrObItXopnJFtuRBEhpyM8np+8VCa5h2t8K
 7YIFvpvJmIiZaAIX9bnssgnsLpQ/cUOx24GQTn8s0Kbz68kvvPS9Xh4AivcR+XVfAOkt
 fC6yXw0CODADgxm3fshtGms2wxoem9SZ3MJjfcFa5n7BLtcKH8TsrwXlgcnVutCUJqQ4
 DFHmjlMy02alzYf03M0OtPU116D9WnyvNmbuhuzEb1JyeZaFytE93mSZ87ReYx92XQSa tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfem3h07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 11:42:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052BXPoh143134;
        Tue, 2 Jun 2020 11:42:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31c12p1drp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 11:42:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052Bg8xP007135;
        Tue, 2 Jun 2020 11:42:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 04:42:07 -0700
Date:   Tue, 2 Jun 2020 14:41:58 +0300
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
Message-ID: <20200602114158.GB30374@kadam>
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
 <87imgai394.fsf@mpe.ellerman.id.au>
 <a3c158fa-3829-f38a-9202-8984b5ef5f21@web.de>
 <87a71liucy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a71liucy.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:23:57PM +1000, Michael Ellerman wrote:
> Markus Elfring <Markus.Elfring@web.de> writes:
> >>>> Please just remove the message instead, it's a tiny allocation that's
> >>>> unlikely to ever fail, and the caller will print an error anyway.
> >>>
> >>> How do you think about to take another look at a previous update suggestion
> >>> like the following?
> >>>
> >>> powerpc/nvram: Delete three error messages for a failed memory allocation
> >>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> >>> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> >>> https://lore.kernel.org/patchwork/patch/752720/
> >>> https://lkml.org/lkml/2017/1/19/537
> >>
> >> That deleted the messages from nvram_scan_partitions(), but neither of
> >> the callers of nvram_scan_paritions() check its return value or print
> >> anything if it fails. So removing those messages would make those
> >> failures silent which is not what we want.
> >
> > * How do you think about information like the following?
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=f359287765c04711ff54fbd11645271d8e5ff763#n883
> > “…
> > These generic allocation functions all emit a stack dump on failure when used
> > without __GFP_NOWARN so there is no use in emitting an additional failure
> > message when NULL is returned.
> > …”
> 
> Are you sure that's actually true?
> 
> A quick look around in slub.c leads me to:
> 
> slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
> {
> #ifdef CONFIG_SLUB_DEBUG

You first have to enable EXPERT mode before you can disable SLUB_DEBUG.
So that hopefully means you *really* want to save memory.  It doesn't
make sense to add a bunch of memory wasting printks when the users want
to go to extra lengths to conserve memory.

regards,
dan carpenter

