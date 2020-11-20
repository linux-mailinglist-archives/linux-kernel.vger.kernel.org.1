Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8D2BB122
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgKTRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:02:58 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54090 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgKTRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:02:56 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AKGufil025197;
        Fri, 20 Nov 2020 11:02:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=lHzuTx5zBZO8e0i7cbdPn9avlsdW5pQeahoVMIU9mWE=;
 b=clpVd3fiK4h/h8iZJbuQWr/CU9sdgt1UqyD4QMf4wI/vqhT22BCAtdye1glVl+Hknxw/
 eQDt4YttWrr2hvjBcoVUUjgqZ/MFlwyYnHQlocWmhzH7mnN8LrCLMj5MZwcJNzemuTO0
 fgre+rGC4kvDSIl1PWn8j9m4RiISaQtuOc6ori0yOOVGCjqr9J8mlygiukFSKjL/Wg7i
 1f3YjDqVnY57zlz1i6T6qns4ZMfNempn7u2U0dfPquQw3EBBqFlgKKAWTBZEzp7ipi96
 ZDPeIOnellsWxWUKwdwQcuNbrT29ZDtgp0KJ36P/wcNdwTyNECiZ5IG/6CyiRCrHQzF8 Nw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 34tchttejv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 11:02:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 20 Nov
 2020 17:03:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 20 Nov 2020 17:03:07 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CA0662C1;
        Fri, 20 Nov 2020 17:02:51 +0000 (UTC)
Date:   Fri, 20 Nov 2020 17:02:51 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 14/16] mfd: wm8994: drop of_match_ptr from of_device_id
 table
Message-ID: <20201120170251.GG10899@ediswmail.ad.cirrus.com>
References: <20201120162133.472938-1-krzk@kernel.org>
 <20201120162133.472938-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120162133.472938-14-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:21:31PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
> 
>   drivers/mfd/wm8994-core.c:618:34: warning: ‘wm8994_of_match’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
