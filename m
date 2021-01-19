Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD72FAEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405735AbhASCVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:21:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405608AbhASCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:21:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10J2BJYW001170;
        Mon, 18 Jan 2021 21:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+ijC5B9LGHCd59fCrivuX0XsD/MFsM/npCAcNaKHsr8=;
 b=EEqO02eZ2Fo2d1IuacCQTY4GQI+RhPVZ6NUfbVd5sBlW5lxuVlgZWEsu7pPL06ag3zHm
 //s7crA6C2IhnwCgQ4xBp2xZVD4fhJGa4H9RrivCOEcNpEiRt3jBJzO0VSXnGA1O9b6h
 AMqeJjhlc7upgAXvcfdHM9CpS9P0TMC+x+tGtRXkDDT/26LIfNGCpqoErWLfitY2B9yB
 C/SaAK1ncupY2FbFiw8JraSXyfKdXhg4vlS3tE53shYEcEps/lpRfAAxSoCpcclVWU9d
 7iHoCNZGjnDqxA/P77z+nCGWfw391J7ZNRmWbp7D+dTj71cmtO+BxrFWAb7vX1zX9Eqr Dw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365p2dge29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 21:20:16 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10J2D2dW022784;
        Tue, 19 Jan 2021 02:20:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 36454vs2v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 02:20:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10J2KBjw18743652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 02:20:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC320A4040;
        Tue, 19 Jan 2021 02:20:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC88A405B;
        Tue, 19 Jan 2021 02:20:07 +0000 (GMT)
Received: from [9.81.211.54] (unknown [9.81.211.54])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jan 2021 02:20:07 +0000 (GMT)
Message-ID: <02b792c847ea1841603629ba0377cfdfff479882.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for
 ast2600-A2
From:   Joel Stanley <joel@linux.ibm.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrewrj@au1.ibm.com,
        BMC-SW@aspeedtech.com
Cc:     joel@jms.id.au, Andrew Jeffery <andrew@aj.id.au>
Date:   Tue, 19 Jan 2021 12:50:05 +1030
In-Reply-To: <20210118100813.30821-2-ryan_chen@aspeedtech.com>
References: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
         <20210118100813.30821-2-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_15:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190010
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-18 at 18:08 +0800, Ryan Chen wrote:
> AST2600A1/A2 have different pll calculate formula.

To clarify, only the A0 has the old calculation, and all subsequent
revisions use the new calculation?

If this is the case, do we need to support A0 in mainline linux, or
should we drop support for A0 and only support A1, A2 and onwards?

You should add a line to indicate this is a fix:

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Also, when sending single patches you do not need to include the cover
letter. You should include all of the relevant information in the
patch's commit message.

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bbacaccad554..8933bd1506b3 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -17,7 +17,8 @@
>  
>  #define ASPEED_G6_NUM_CLKS             71
>  
> -#define ASPEED_G6_SILICON_REV          0x004
> +#define ASPEED_G6_SILICON_REV          0x014
> +#define CHIP_REVISION_ID                       GENMASK(23, 16)
>  
>  #define ASPEED_G6_RESET_CTRL           0x040
>  #define ASPEED_G6_RESET_CTRL2          0x050
> @@ -190,18 +191,34 @@ static struct clk_hw *ast2600_calc_pll(const
> char *name, u32 val)
>  static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
>  {
>         unsigned int mult, div;
> +       u32 chip_id = readl(scu_g6_base + ASPEED_G6_SILICON_REV);
>  
> -       if (val & BIT(20)) {
> -               /* Pass through mode */
> -               mult = div = 1;
> +       if (((chip_id & CHIP_REVISION_ID) >> 16) >= 2) {
> +               if (val & BIT(24)) {
> +                       /* Pass through mode */
> +                       mult = div = 1;
> +               } else {
> +                       /* F = 25Mhz * [(m + 1) / (n + 1)] / (p + 1)
> */
> +                       u32 m = val & 0x1fff;
> +                       u32 n = (val >> 13) & 0x3f;
> +                       u32 p = (val >> 19) & 0xf;
> +
> +                       mult = (m + 1);
> +                       div = (n + 1) * (p + 1);
> +               }
>         } else {
> -               /* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
> -               u32 m = (val >> 5) & 0x3f;
> -               u32 od = (val >> 4) & 0x1;
> -               u32 n = val & 0xf;
> +               if (val & BIT(20)) {
> +                       /* Pass through mode */
> +                       mult = div = 1;
> +               } else {
> +                       /* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)]
> */
> +                       u32 m = (val >> 5) & 0x3f;
> +                       u32 od = (val >> 4) & 0x1;
> +                       u32 n = val & 0xf;
>  
> -               mult = (2 - od) * (m + 2);
> -               div = n + 1;
> +                       mult = (2 - od) * (m + 2);
> +                       div = n + 1;
> +               }
>         }
>         return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
>                         mult, div);


