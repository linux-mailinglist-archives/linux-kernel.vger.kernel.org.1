Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6642444DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 08:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHNGHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 02:07:21 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:36584 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgHNGHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8B783180188BD;
        Fri, 14 Aug 2020 06:07:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3150:3354:3622:3865:3866:3867:3868:3871:3873:4321:4385:4419:5007:9592:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12683:12740:12760:12895:12986:13439:14096:14097:14181:14659:14721:21080:21325:21451:21627:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: shirt72_4110c3e26ffa
X-Filterd-Recvd-Size: 3581
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 06:07:17 +0000 (UTC)
Message-ID: <d1414df440b872ab7792946725991cb948537654.camel@perches.com>
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
From:   Joe Perches <joe@perches.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Aug 2020 23:07:16 -0700
In-Reply-To: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-13 at 20:45 +0800, Youling Tang wrote:
> Regardless of whether the ret value is zero or non-zero, the trajectory
> of the program execution is the same, so there is no need to compare.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 78c0837..3ad0ae2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
>  						     digest, SHA256_DIGEST_SIZE, 0);
> -		if (ret)
> -			goto out_free_digest;
>  	}
>  
>  out_free_digest:

If you really want to change the function, then
you could change a couple of breaks to gotos,
remove multiple unnecessary tests, and unindent
a block of code too.

---
 kernel/kexec_file.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..34a025e85887 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -763,7 +763,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
-			break;
+			goto out_free_digest;
 
 		/*
 		 * Assume rest of the buffer is filled with zero and
@@ -777,32 +777,26 @@ static int kexec_calculate_store_digests(struct kimage *image)
 				bytes = zero_buf_sz;
 			ret = crypto_shash_update(desc, zero_buf, bytes);
 			if (ret)
-				break;
+				goto out_free_digest;
 			nullsz -= bytes;
 		}
 
-		if (ret)
-			break;
-
 		sha_regions[j].start = ksegment->mem;
 		sha_regions[j].len = ksegment->memsz;
 		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-						     sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
+	ret = crypto_shash_final(desc, digest);
+	if (ret)
+		goto out_free_digest;
 
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
-						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
+					     sha_regions, sha_region_sz, 0);
+	if (ret)
+		goto out_free_digest;
+
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
+					     digest, SHA256_DIGEST_SIZE, 0);
 
 out_free_digest:
 	kfree(digest);


