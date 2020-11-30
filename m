Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665EE2C8167
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgK3JwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:52:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgK3JwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:52:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU9WPaL050805;
        Mon, 30 Nov 2020 04:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ycxEx1i1IRZUpVbXkfam4zlw10HsuI7crQWaxouBRTo=;
 b=KORbiVe+XpLWjSnAkih0eD9hmeyuN/3sZz0uUf1/KQ6EDhmMLxdJXqXl3GTfgukBnb+V
 DMRuQgLiP8PKNISPhZKjvn8hqRs07tYzd6dfUn9YbJg8SDX7yl2d9iK6rk2913RTLbqd
 pg85zaHxXnQgx7CNrNdKOwwDLNPyUpLrmMzU4x7bAJDcUdPHc310TUQ4dZqd3I9Mz/l1
 G3A0gYe07tKGfa8JMQTHG6ZSTovS7nbCCzVBxSEDsiydZFrKYmzoHgE9ZSLzwEw2p9HV
 rN/TtrvJe+tA+T1UT+5y0/YNHKcgVTiJYuIjCUtjqVqs8XG8mK+iqa4EUM1RhSVbU09P sQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 354x45gk5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 04:51:23 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU9Wg13020332;
        Mon, 30 Nov 2020 09:51:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 353e682t23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 09:51:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU9o2PM27394496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 09:50:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D368752054;
        Mon, 30 Nov 2020 09:50:02 +0000 (GMT)
Received: from [9.171.29.181] (unknown [9.171.29.181])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A165352052;
        Mon, 30 Nov 2020 09:50:02 +0000 (GMT)
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
 <20201127095633.60f8a544.pasic@linux.ibm.com>
 <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
 <20201127163936.38a51c15.pasic@linux.ibm.com>
 <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
 <20201130095549.27da927f.pasic@linux.ibm.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <bc52205b-9ae8-98c6-0eb0-9fff551c7868@linux.ibm.com>
Date:   Mon, 30 Nov 2020 10:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201130095549.27da927f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_02:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/20 9:55 AM, Halil Pasic wrote:
> On Mon, 30 Nov 2020 09:30:33 +0100
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> 
>> I'm not really familiar, with it but I think this is closely related
>> to what I asked Bernd Nerz. I fear that if CPUs go away we might already
>> be in trouble at the firmware/hardware/platform level because the CPU Address is
>> "programmed into the device" so to speak. Thus a directed interrupt from
>> a device may race with anything reordering/removing CPUs even if
>> CPU addresses of dead CPUs are not reused and the mapping is stable.
> 
> From your answer, I read that CPU hot-unplug is supported for LPAR. 

I'm not sure about hot hot-unplug and firmware
telling us about removed CPUs but at the very least there is:

echo 0 > /sys/devices/system/cpu/cpu6/online

>>
>> Furthermore our floating fallback path will try to send a SIGP
>> to the target CPU which clearly doesn't work when that is permanently
>> gone. Either way I think these issues are out of scope for this fix
>> so I will go ahead and merge this.
> 
> I agree, it makes on sense to delay this fix.
> 
> But if CPU hot-unplug is supported, I believe we should react when
> a CPU is unplugged, that is a target of directed interrupts. My guess
> is, that in this scenario transient hiccups are unavoidable, and thus
> should be accepted, but we should make sure that we recover.

I agree, I just tested the above command on a firmware test system and
deactivated 4 of 8 CPUs.
This is in /proc/interrupts after that:

...
  3:       9392          0          0          0   PCI-MSI  mlx5_async@pci:0001:00:00.0
  4:     282741          0          0          0   PCI-MSI  mlx5_comp0@pci:0001:00:00.0
  5:          0          2          0          0   PCI-MSI  mlx5_comp1@pci:0001:00:00.0
  6:          0          0        104          0   PCI-MSI  mlx5_comp2@pci:0001:00:00.0
  7:          0          0          0          2   PCI-MSI  mlx5_comp3@pci:0001:00:00.0
  8:          0          0          0          0   PCI-MSI  mlx5_comp4@pci:0001:00:00.0
  9:          0          0          0          0   PCI-MSI  mlx5_comp5@pci:0001:00:00.0
 10:          0          0          0          0   PCI-MSI  mlx5_comp6@pci:0001:00:00.0
 11:          0          0          0          0   PCI-MSI  mlx5_comp7@pci:0001:00:00.0
...

So it looks like we are left with registered interrupts
for CPUs which are offline. However I'm not sure how to
trigger a problem with that. I think the drivers would
usually only do a directed interrupt to a CPU that
is currently running the process that triggered the
I/O (I tested this assumption with "taskset -c 2 ping ...").
Now with the CPU offline there cannot be such a
process. So I think for the most part the queue would
just remain unused. Still, if we do get a directed
interrupt for it's my understanding that currently
we will lose that.

I think this could be fixed with
something I tried in a prototype code a while back that
is in zpci_handle_fallback_irq() I handled the IRQ locally.
Back then it looked like Directed IRQs would make it to z15 GA 1.5 and
this was done to help Bernd to debug a Millicode issue (Jup 905371).
I also had a version of that code meant as a possible performance
improvement that would check if the target CPU is
available and only then send the SIGP and otherwise handle it
locally.

> 
> Regards,
> Halil
> 
