Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674352C8065
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgK3I4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:56:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgK3I4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:56:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AU8WjhT159060;
        Mon, 30 Nov 2020 03:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=g2vNIH73GKpHarEpLnkjsrzo54bJhlCVWTzhmiy3Xq4=;
 b=HzBBi3dmrhtHDXsYIj9EZpXfUYdEM5aqYprzFZoD0QvYSQkKWahsbIgMX4c5MGVrr8WV
 POC333oPZ5m18oVqnXm3bobY/xAgXjDkQfumBbgHGh4layJ56mSLCd6JBEuEJK8W+VAn
 +USwsyznL4lLsNt0tuL0RP21kPb0BEjWa/abU/d1p6p68XLAOKraZm5+6hK3BX88GXCM
 0YICqwFWfaBHJ17w29fbeRfbzagMTjW6aCLZMA/wy8vFEmd4YQHKcp8iR5lveE35hls6
 h2ZpmqZG3tMJaxQ0CUK+iwaZejZ5YcC1zFfLsJEYhZ1a1hLej3aegY8+bV9XYOgwwKyG 4A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 354w7v0pfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 03:55:56 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AU8loZT007949;
        Mon, 30 Nov 2020 08:55:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 353e681u2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 08:55:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AU8tpg16292148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 08:55:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E104C04E;
        Mon, 30 Nov 2020 08:55:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D7C44C046;
        Mon, 30 Nov 2020 08:55:51 +0000 (GMT)
Received: from oc2783563651 (unknown [9.171.74.188])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 30 Nov 2020 08:55:51 +0000 (GMT)
Date:   Mon, 30 Nov 2020 09:55:49 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201130095549.27da927f.pasic@linux.ibm.com>
In-Reply-To: <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
References: <1606410037-11436-1-git-send-email-agordeev@linux.ibm.com>
        <20201127095633.60f8a544.pasic@linux.ibm.com>
        <16fe9017-407f-1bb0-1599-fb46d93009fc@linux.ibm.com>
        <20201127163936.38a51c15.pasic@linux.ibm.com>
        <2400bc6a-ff0a-f0b8-66fc-25e11032dacb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_02:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 09:30:33 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> I'm not really familiar, with it but I think this is closely related
> to what I asked Bernd Nerz. I fear that if CPUs go away we might already
> be in trouble at the firmware/hardware/platform level because the CPU Add=
ress is
> "programmed into the device" so to speak. Thus a directed interrupt from
> a device may race with anything reordering/removing CPUs even if
> CPU addresses of dead CPUs are not reused and the mapping is stable.

=46rom your answer, I read that CPU hot-unplug is supported for LPAR.=20
>=20
> Furthermore our floating fallback path will try to send a SIGP
> to the target CPU which clearly doesn't work when that is permanently
> gone. Either way I think these issues are out of scope for this fix
> so I will go ahead and merge this.

I agree, it makes on sense to delay this fix.

But if CPU hot-unplug is supported, I believe we should react when
a CPU is unplugged, that is a target of directed interrupts. My guess
is, that in this scenario transient hiccups are unavoidable, and thus
should be accepted, but we should make sure that we recover.

Regards,
Halil
