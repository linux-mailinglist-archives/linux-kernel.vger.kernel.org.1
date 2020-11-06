Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7D2A9A59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKFRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:02:54 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56212 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbgKFRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:02:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Gw9xf008252;
        Fri, 6 Nov 2020 18:01:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=uZBV8n4mMkde4jjAqjB9u7d5zjrddtyOYSHkQR0yWT0=;
 b=GlBrR15FDgSjHbKzcM3/S6sURlZ4LTote0SFOE3JGvwsW4BqbPstlzez9WdA/50hio8y
 NCCX24+58XBb+Ny0ivGmGE0udME7kHcEfFqHqVuVsz5dDO9ZzMgq6h3tl7L7BueR51un
 NFRCJ78mvNoStxdpaoLFCUOpvoXkpmnwi8La31op9HQ1+yQK5eL5WAfMkvJCJBPMtG2u
 bH5k+aWOsFX9DWHy7cKKldWka6icYwBD4DDHaLAHeFlcThMEzCpKxpPz/JAdGFoWmaCC
 51Eo8dIPmiz53SJobt98YOJFgt5mUPHjr9x415rY+Cl5gRK5q3IqvR53vVoVuHLX0lh1 Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00ewkg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 18:01:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AE0110002A;
        Fri,  6 Nov 2020 18:01:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19DFB219D0E;
        Fri,  6 Nov 2020 18:01:35 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 18:01:33 +0100
Subject: Re: [PATCH v4 2/5] dt-bindings: usb: Add DT bindings for STUSB160x
 Type-C controller
To:     Rob Herring <robh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20201106091854.14958-1-amelie.delaunay@st.com>
 <20201106091854.14958-3-amelie.delaunay@st.com>
 <20201106161709.GA3297832@bogus>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <aa30c00b-383d-29d4-c782-ae8781354de9@st.com>
Date:   Fri, 6 Nov 2020 18:01:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106161709.GA3297832@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/20 5:17 PM, Rob Herring wrote:
> On Fri, 06 Nov 2020 10:18:51 +0100, Amelie Delaunay wrote:
>> Add binding documentation for the STMicroelectronics STUSB160x Type-C port
>> controller.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../devicetree/bindings/usb/st,stusb160x.yaml | 85 +++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/st,stusb160x.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/st,stusb160x.yaml: ignoring, error in schema:
> warning: no schema found in file: ./Documentation/devicetree/bindings/usb/st,stusb160x.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1395559
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
I already ran 'make dt_binding_check' but st-schema was not up to date, 
despite a not so old upgrade.
I note for next time to do the upgrade autotically before the 'make 
dt_binding_check'.

New version submitted.

Thanks,
Amelie
