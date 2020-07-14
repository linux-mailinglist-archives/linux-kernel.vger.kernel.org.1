Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4921E508
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 03:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGNBWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 21:22:54 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31]:36112
        "EHLO sonic315-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgGNBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1594689773; bh=kSZ8A/K3JBp8LhqRTcQFI6Kag9kj97BCjG/6uEWAlZc=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=ODio+wTgG8PN6r2cbOHOkXApXvS1xdIi6NXA4PImpbo92ezGIVt3qYUGr3XfmyJF+yz9QOZC7ctmV8OcDl1V5YodnuMr1ZFW0/rHZZBP33k6tRTFN9Zdzdpe11PIaQcCkGq5Vok7ibIRQqAxVpAxHF7k8qT4VeZduSu2Uam/W/O2J80rNGlI1JO8LwSWXlT2A4e4I0wcJgFX8cOqQlb9dmKvgIxk9BZxMVnKjvvY8LPhpVplhLBpbkqukIDPqUxBwEU0yQZsxf8qjXdA8Zr60JcYF65JxYf1BRA8DB5LoeU/b6ER96lnkGBNDGNBvBrHfJ5BbyGrdydPQ3ODolpAMg==
X-YMail-OSG: .wzDUJ0VM1mceQnxa9_yhOOOke64Dafy9Q9UDbMovPnBzGAmgBzLsOJ7LySXt5a
 9J3R9gX9oe_eAvBUo_B055.hPtrQKHHBimBiKNacZeirx8lMzsr8YJBmlNwgPsIUi3zuoOR8xMEh
 .xD86sEv2WRKPKgvI9IdWwr5suBNFi8ZFZYR_saqcru2b9BpMjZiHPlOhde2PpzD1CkGrkcv_rkT
 qrz2FY29v5MDLxPO7XAw6g5jOSwCJfhNBw4Wr4yavjFgsFbUVpvL9spTDdyjO6fWQOWQSr_sExdv
 xyth76vWEaYH6Ha2VNbOjdnOQzTH3jjgiKc.qx_JeiBSE3OtQA0SUw5CkMzX55wTJEgslA3ZELuU
 I4zajfP7.ITRLJpVvq_SzemDEB6Cx2FTN.6dPlqa_NNfll5opyWdhECoNI06Ba0_X.rIKk000kvb
 1f3v3U39bBgm8c9y4EUs1xlVkoB20_Xyx3rvVgN5h1rh1uPZnLguOLr2.Mia3xZMzJGVBE4tIYzN
 rP5amZ935LW3ov.pGZWs2fNa0BVStIy7nMIChTgC75q1BmlISgtEAT.8Mo5Q.CQ5QRgasnFUr429
 iW4cR9ZoAsAe6OnmF7Lb5.oZ_DXWInpjHSAbC.kiroM4jtSDjvgc8nqP8NuM7KI4BGjQXW121r94
 aGtsjEySM2LoEa2svcNlY.gIhZD7jOWOph4F38tqbre7ORBLhuCyK8S70kneBU6lHYJEVVIhhac.
 1BsZq2oLgZrTAsFLLzLUJsEu_TWxyDyjjrGX4IIz3g2MMeT.g3aqqcpunRXMNxT8Ax5uvG4hg5H0
 RHSXZ5rpdYM.4q077o8GTu2es118G3Duh0JlOcGVWbVj92BoSkWyVaCAzgo9PdwvXSZdgN9aLoVe
 W4CDO319FR_fZx2kSly6a08v9.p8SxbAyE27CDzgyEbeshWIf6goUofcGQ75lHyw.7B7ud4hH3YW
 eAogDELd2AZBbndnSFpF4oj27JCVmSckNAL972OqJceHhf4Zq6uHeo3UtflRq7pPNbhgItHuGN0L
 xj2fNssv4F6BaYMCnENMYwnB_EtpvHz4_m1R7blesOIm02bcdW.EK9nYDkHSjHoNTwCv9pIgZNZy
 kqM0lpLDkoDRZm_s5voyIMhHg065MosNVMU0iVsnqb.DkEngb2duuQTUGwVk.tky2h2EO2Nk1Rjh
 JI_yAxzmiNp2r9mW4E1zXPvGU04r3BXExwVkEO04Yd.ocJ_UQvoYUOnluZR8wGVN8So4jmhWp5cz
 KCr2q8eH9IoHQQF7nS55l572onKVaIgsMCU1I6a8sDf0Zn7DRyqDo0e2y9wH_5U8SqJH9djPq9CB
 XWxnwQO0HSxE1bGZBWCdaNzjzqZq428dy0QBJWplYEkPBMHnAp325Akn6tCdzp_y6_ZqF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 14 Jul 2020 01:22:53 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ccb2d8946b485b8111546e619c1c7f07;
          Tue, 14 Jul 2020 01:22:51 +0000 (UTC)
Date:   Tue, 14 Jul 2020 09:22:46 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Replace HTTP links with HTTPS ones
Message-ID: <20200714012244.GA18418@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200713130944.34419-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713130944.34419-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16271 hermes_aol Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:09:44PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(Will apply later with other potential patches...)

Thanks,
Gao Xiang
