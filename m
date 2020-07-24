Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18F022C72F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGXN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:59:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbgGXN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:59:14 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ODrl1D022365;
        Fri, 24 Jul 2020 15:58:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=KRUo6+0et9uIWzr/7OGkArIbrkrXoASlOdUHAzwrQ+c=;
 b=o4tYZ167aIAxYvG71/FxDIp91Y1Gl3UWSaaPkCo/tPveq6Rp1PD4p6uJo7eG/TRCpSrr
 4oz3oWk5Ge+YQ9BVEoqj+gbxiP+M25v2/4yKJk2n0vb1y52THqdiO2oX9r8Ie9RGZN1y
 w6pJ5JpPu5ini7M89305qeM9d8QaP6TLpYJdcPr8JwzJAKj491Nc+oM2J74+/cUGxhNj
 DCAaWGs3usAwNJXCW1mODvpK2DtZxKnNt8ZM2YhzF2yBbDyIQHTMcFaTdzID+A8kbUSZ
 LVz+Wm/JRsR8RD0wU/bQnzdQYlAvidy+qemtpIcFXMSSx5PQYfE17Lmk5QM6U717JD1u 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsfq0hx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 15:58:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DBB110002A;
        Fri, 24 Jul 2020 15:58:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2557C2B4D1F;
        Fri, 24 Jul 2020 15:58:57 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jul
 2020 15:58:56 +0200
Subject: Re: [PATCH v3 0/3] Add USB role switch support to DWC2
To:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20200724104711.5474-1-amelie.delaunay@st.com>
 <4c44f596-d2c3-6d2f-bf28-9e3964b6e6f1@st.com> <878sf9owcw.fsf@kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <fcff5f96-8383-fd84-35f1-3eb291cd65df@st.com>
Date:   Fri, 24 Jul 2020 15:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sf9owcw.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/24/20 3:50 PM, Felipe Balbi wrote:
> 
> (no top-posting, please)
> 
> Hi,
> 
> Amelie DELAUNAY <amelie.delaunay@st.com> writes:
>> Series dropped.
> 
> what do you mean with this? Should I drop all patches related with this series?
> 

As v1 patches were in your next branch, I've prepared a new patchset 
which contains fixes, on top of you next branch :
https://lore.kernel.org/patchwork/project/lkml/list/?series=454959


What do you prefer ? Drop all patches related to the v1 "Add USB role 
switch support to DWC2" series and I send a v4 in replacement or keep 
all patches and wait for new series review ?
