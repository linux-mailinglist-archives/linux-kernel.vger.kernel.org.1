Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947392A0C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgJ3Rb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:31:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35492 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ3Rb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:31:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UHFuFj016569;
        Fri, 30 Oct 2020 17:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=cO/wbrA8K8R/8ZZu3osq1liqvVN+DhE/Wl18SkovPeg=;
 b=q5gpbysxO5Z2p+j3T/a2KsJ71G0IweksABomemSgKARlCOntKiMm9PnHs7AcBv1y4Akc
 b7DOcgutMwoVMRS9spu5yifOxXkp1/hUUvSszu64bSA4r1JjcRgoQntadAP4nyZuqbkH
 3Uyv/kdAIcV1wbSIszICrPD44/QOxMF95uS3c5ZgVaMi7R7ExACDcUg+gPcZM12he/9v
 V7EraTtDPJWpR3JkHc7jPA+qU53Jg/O1hoZO7XHvQNdukVRrNdKlVIGySCFkt1dMVgKa
 JtTxtZWjTiEJu+MmB5bKlM0M6ykvhr9LNDcH0/QnYJP3b82EgRM1sJT+lcMmGeKVdTtC ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sbayaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 17:18:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UHAaGk023110;
        Fri, 30 Oct 2020 17:18:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwur6ve0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 17:18:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09UHIkdl021029;
        Fri, 30 Oct 2020 17:18:46 GMT
Received: from dhcp-10-154-181-248.vpn.oracle.com (/10.154.181.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 10:18:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH 4.14 v2 ] platform/x86: Corrects warning: missing braces
 around initializer
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20201030165227.GR4077@smile.fi.intel.com>
Date:   Fri, 30 Oct 2020 12:18:44 -0500
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <105E5DC2-1B23-40BF-95A1-1B8443575AF6@oracle.com>
References: <20201030155501.7491-1-john.p.donnelly@oracle.com>
 <20201030165227.GR4077@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2020, at 11:52 AM, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
> On Fri, Oct 30, 2020 at 08:55:01AM -0700, john.p.donnelly@oracle.com =
wrote:
>> From: John Donnelly <john.p.donnelly@oracle.com>
>>=20
>> The assignment statement of a local variable "struct tp_nvram_state =
s[2] =3D {0};
>> is not valid for all versions of compilers.
>=20
> I don't get the subject. IS it backport of existing change to v4.14, =
or you are
> trying to fix v4.14? If the latter is the case, it's not correct =
order. Try
> latest vanilla first (v5.10-rc1 as of today) and if there is still an =
issue,
> submit a patch.

Hi,

 It is only intended for 4.14. Why would you back port  a commit  to a =
stable tree that emits warnings ?




>=20
>> Fixes: 515ded02bc4b ("platform/x86: thinkpad_acpi: initialize =
tp_nvram_state variable")
>>=20
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>=20
> Should not be blank line in between.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

