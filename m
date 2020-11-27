Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7822C667D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgK0NMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:12:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730098AbgK0NMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:12:54 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCR5IV006586;
        Fri, 27 Nov 2020 14:12:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=GQp9+1KGBlt8NZocRR5PgA4+6R9ARvYpJUhtHSdjap4=;
 b=Es7xEDIEJ0QUnArrxgnbGB9ZxyUqE2gRrKoKk1LMIIwkaPTvfMJlIjf4olaABz+Oj9gS
 mOsI4nDjHhhh3Y2PfwK91qfIWAXBTUGNX/spvS96z3TGW6WQwD67OUhDPnDVQhp6nhyr
 UpmqGS3GPa2MeTGceActUCeO8JWwmraJUymkGDYRAZ5wGrQ5msgBDtvh0T02wwIu+Rs0
 TkcEysSPK7xn6x9YrnncOIuA20AA7RF5o5BtO/Ibgxc9N+73i6bUepBp8bSCfR8lfuRT
 NyEgeT81XIN/RUT+TK5glb3v/0RpY+dV+ULl+PPMt668MwgPlINY8Tf17NyLr5qp6Ijj Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0fhdnvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:12:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AC6510002A;
        Fri, 27 Nov 2020 14:12:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4234A24A63B;
        Fri, 27 Nov 2020 14:12:32 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 14:12:30 +0100
Subject: Re: [PATCH v5 3/5] usb: typec: stusb160x: fix power-opmode property
 with typec-power-opmode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-4-amelie.delaunay@st.com>
 <e97a537a-9c7e-cd98-8ffa-93abae087128@st.com> <X8D6LgTHMpk2gph9@kroah.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <b9bd4d0f-a6e4-29f4-77aa-9d144edff18c@st.com>
Date:   Fri, 27 Nov 2020 14:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8D6LgTHMpk2gph9@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 2:07 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 27, 2020 at 02:01:29PM +0100, Amelie DELAUNAY wrote:
>> Hi Greg,
>>
>> gentle reminder for this patch, lost in the middle of a DT series (DT part
>> already in stm32-next).
> 
> Odd, I don't see this anymore, can you resend just this one so I can
> apply it directly?

Sure :) I rebase it and send it right now.

Amelie
