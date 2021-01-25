Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93A30215E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAYErO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:47:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbhAYErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:47:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10P4iSPF160005;
        Mon, 25 Jan 2021 04:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TLncA71vshE7G5s6VEqFUz6kf2+cMWqNp6LoX3eY794=;
 b=TdJq/4Zz/jqHF0WKbcu/oeWC2H7AKNt6BPutTT/PuRP4cFAnQc0oNhzNi/K93rMvwQnY
 /7LxqHa/MXa9Z2KJdyvTrq2lptJ2juFe3h4uzBbQfI9bUWEgZYMPaV+uPGZ/FGH7QS0M
 ciX8VH2AKAOrvO8H4MDWMmrcPPrumqOG1qRNMMddRh2uR4FD+8/njrCJiFXZuX7PNOsc
 NWO2LqzDx98Kt6vZUKMcVoKMDjr1+nGfrjzAZ6SbaLFiEUw3RyJzeHCJpkxawB8wNiIH
 FxnDq0TwkCVyy0Qzk6kjDFdo9IpomxtKLQRZhvoD+O06vlCGZv+v9UFJQnxMb8Ws7pd7 Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 368brkbe5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 04:45:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10P4a1sI053121;
        Mon, 25 Jan 2021 04:43:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 368wqueddb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 04:43:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10P4hV35025889;
        Mon, 25 Jan 2021 04:43:31 GMT
Received: from santoshs-mbp-3.lan (/69.181.241.203) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Sun, 24 Jan 2021 20:42:07 -0800
ORGANIZATION: Oracle Corporation
USER-AGENT: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <3d9c2585-1636-2542-15b8-9ae89995456c@oracle.com>
Date:   Sun, 24 Jan 2021 20:42:06 -0800 (PST)
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To:     David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for TI AM18XX/OMAP-L138 PRUSS
References: <20210104183021.330112-1-david@lechnology.com>
In-Reply-To: <20210104183021.330112-1-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 10:30 AM, David Lechner wrote:
> This is the first step for adding support for the PRUSS on TI AM18XX/OMAP-L138
> SoCs. This series adds support in the top-level PRUSS driver. (Patches for the
> interrupt controller and individual PRUs are independent of this change and
> will be submitted separately.)
> 
> David Lechner (2):
>    dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
>    soc: ti: pruss: add support for AM18XX/OMAP-L138 PRUSS
> 
Please post updated series after fixing patch 2 as discussed with Suman.

Regards,
Santosh
