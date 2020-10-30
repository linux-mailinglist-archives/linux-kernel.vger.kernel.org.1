Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4C2A0A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJ3P4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:56:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3P4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:56:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFtCic029929;
        Fri, 30 Oct 2020 15:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=EVU30gD91LGa1Y1VdxSOZe8O/74NXoz9gkkfDNj0ves=;
 b=Sa+1udKUyhvhEs5UdIrzRdpV+Dpi9n5+Q7HSsbzu6Ajbh9ICzefahIoKgQqD1qGBsEwP
 yhHo7kAzcMjblYqLXyHZU4TAd3LIzfc8TNabWSONyhL9dL70hLk6J1wa+NqsMPwpDB2e
 He59UWMd4JRlIoNprJRmcEs8TAgH2yoj1mcP8sGcd29MbEGu3Hk2THfGb6eFJSjWZJJR
 mzd/vXuai8YDzY1DZr6EaBAR5XzLoVN9qGHMPNgw1Lcsjbh93QffHFogEukjfZB+o3u6
 iyz7umRhWtY4s7IX5cKY3ChqjfQKhoEM+6Puu/CoQViZDqKr8gwb03fzXsURM73Sk+M6 lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7mae9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:56:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFuRiA079053;
        Fri, 30 Oct 2020 15:56:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1um638-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 15:56:27 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UFuLEa015836;
        Fri, 30 Oct 2020 15:56:21 GMT
Received: from dhcp-10-154-181-248.vpn.oracle.com (/10.154.181.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 08:56:20 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH 4.14 ] platform/x86: Corrects warning: missing braces
 around initializer
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20201030155211.7218-1-john.p.donnelly@oracle.com>
Date:   Fri, 30 Oct 2020 10:56:19 -0500
Cc:     trix@redhat.com, andriy.shevchenko@linux.intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8B7C690-0EDE-4545-AEC1-D1B227B636C1@oracle.com>
References: <20201030155211.7218-1-john.p.donnelly@oracle.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=5 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=5
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2020, at 10:52 AM, john.p.donnelly@oracle.com wrote:
>=20
> From: John Donnelly <john.p.donnelly@oracle.com>
>=20
> The assignment statement of a local variable "struct tp_nvram_state =
s[2] =3D {0}; "
> is not valid for all versions of compilers (UEK6 on OL7).
>=20
> Fixes: 515ded02bc4b ("platform/x86: thinkpad_acpi: initialize =
tp_nvram_state variable")
>=20
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
> drivers/platform/x86/thinkpad_acpi.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c =
b/drivers/platform/x86/thinkpad_acpi.c
> index ffaaccded34e..c41ac0385304 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -2477,7 +2477,7 @@ static void =
hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
>  */
> static int hotkey_kthread(void *data)
> {
> -	struct tp_nvram_state s[2] =3D { 0 };
> +	struct tp_nvram_state s[2];
> 	u32 poll_mask, event_mask;
> 	unsigned int si, so;
> 	unsigned long t;
> @@ -2488,6 +2488,8 @@ static int hotkey_kthread(void *data)
> 	if (tpacpi_lifecycle =3D=3D TPACPI_LIFE_EXITING)
> 		goto exit;
>=20
> +	memset(&s, 0, sizeof(s));
> +
> 	set_freezable();
>=20
> 	so =3D 0;
> --=20
> 2.27.0
>=20

Please ignore and use :

PATCH 4.14 v2 ] platform/x86: Corrects warning: missing braces around =
initializer

