Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823262F11F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbhAKLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:54:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729758AbhAKLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:54:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10BBabIh196079;
        Mon, 11 Jan 2021 06:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=or+DMSFNahJXJOExLmpU8igAXrlWM7Vrz+hgQRMPi0s=;
 b=B0OTdrdgnYcqT7pzlRP0wsSlPvzL2tnndw+5b+IH5vhdSddu/X0F6jYNNa4fzl0a2cmi
 immmVVwbDID2anUeBPM2a7U3Dt7sgXbq2emRfoiBO6TnwM2Eimszoi1lpAD4lHdOZawp
 150hIr9yfAx1nROdEntPAyh0ZPovLwczw4vsDgio4nypG78NxdfFsyasns2coK7/2aDB
 XUBpd9A7Cve4gxscoLqzghWOnw/NFda8ZlSm1gbcQiiKyGGMoNyZl0c8dJpwVmzMgt6w
 DS6UWDRDQ+0HwPwgAAUjtx+v+eV5HaLJB2X5VQhnVUAyE7rERto1YjUt59VqhGxwG6xg Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 360mr4ja2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 06:54:03 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10BBdVb7014162;
        Mon, 11 Jan 2021 06:54:02 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 360mr4ja22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 06:54:02 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10BBm38O024180;
        Mon, 11 Jan 2021 11:54:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 35y448h4uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 11:54:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10BBrw2U31195456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 11:53:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A87C4C04A;
        Mon, 11 Jan 2021 11:53:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E64F4C040;
        Mon, 11 Jan 2021 11:53:58 +0000 (GMT)
Received: from oc8242746057.ibm.com (unknown [9.171.88.27])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jan 2021 11:53:58 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
In-Reply-To: <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
In-Reply-To: 
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
 <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
Date:   Mon, 11 Jan 2021 12:53:57 +0100
Message-ID: <87im83u1t6.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_23:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=886 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> Hi, Alexander,
>
> On 16.12.2020 14:02, Mike Galbraith wrote:
>> Greetings,
>> 
>> With this commit, bisected and confirmed, kdump stops working here,
>> makedumpfile saying "check_release: Can't get the kernel version".
>
> hasn't your commit 55d9e11398a4 "kdump: append uts_namespace.name offset to VMCOREINFO"
> fixed this issue?
>
> What problem with offset we meet here in case of uts_namespace is even marked with __randomize_layout?
>
> Kirill

Hi Kirill,

the makedumpfile fix has been applied on Dec 17 2020.
makedumpfile complains about linux kernel version with newer ones but it should still work.

Regards
Alex
