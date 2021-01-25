Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4421304AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 22:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbhAZEzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:55:01 -0500
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:60064
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbhAYJSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:18:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFvZKvVWw5xDUZNmQSHPhVefERx3iaRDDLRAGk/ISwgs2TzDplVKnFjAoZ5nkr8QIdGKjQ+8qb2WSBrcZGmiVv6PZcK338D5ihzETt9/Rt4ygjLlt26Liv99n5T1ebIJ3Pe8odGxsCbs1n5DbtcJRMhJ1hwKdXdPrDQg4arYeecfozVRkNy5xkjtRkAMJBL6pxWJKI1QCyRpudm28PIbMxx0wUvFLXSgcVi4NWD0nQ9dAGDabns3FY7VoyoaXx9JEewe9k9KTXuus44Ozqq0AILyYGrQGyXOirMX9uSvGwiNl0d7SV8Vf8q8iCEBtg6IcaUIXc1Wk4/TBCs2tP9Yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhf9jpCXYQD1UulYL69NegAtkyUEivBv0k0kKV38HB8=;
 b=el34X37aRCcysdJckKGb2Jt9lpQ44iV/PkFu6Jnwa5GZ7jLWhRel0yYiKgn5vne0O+AiH3qhBFaEY5wEO61xHZW27HjJ274DPF8Adj9sKjyv4zr6tWB4fJiG7Kkb2RkbkRfv9eX05XpusXj6VHCKBbQFoAZS/T8E+cQHe8RSaMgp3/ogUhoJklc7bMofxWOHDCpWtfJ2lgPjd+4fWD8nGdrZQt3cshd3pwonioqfn9j0R/GRiPkTnt6xyO9ielElErD4ZWTS1WXQEENGlSEFSjELR1k7FuLCaaqCwC2FBsQyQJo4ImSPRujp5rCFSOO4rMOwAnX9wDi2532p3Z6gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhf9jpCXYQD1UulYL69NegAtkyUEivBv0k0kKV38HB8=;
 b=awkJRYpjxowy59vaBBLGGvok/eWlt0t1xCY9sXCScdmTcE43D7n1QPSL6zMSCG+GYWxRDPbq+PAxlhPnV4gf2wZek3enGOJvEPGHIy1BcRM5w9FmLhyRXw1H4lLdHKKVixCB4Py44YScXOlT8wqQUCdL5O/9dRf8sAUI8QbdhkQ=
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 MWHPR0101MB3024.prod.exchangelabs.com (2603:10b6:301:2b::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.19; Mon, 25 Jan 2021 09:17:20 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742%5]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 09:17:20 +0000
From:   Jason Tian OS <jason@os.amperecomputing.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Frank Wang <zwang@amperecomputing.com>,
        Jason Tian OS <jason@os.amperecomputing.com>
Subject: RE: [PATCH] ARM64: RAS: Update code to trace out more data for ARM
 processor
Thread-Topic: [PATCH] ARM64: RAS: Update code to trace out more data for ARM
 processor
Thread-Index: AQHW3L1L6HwWR7hjC0CmDTUQHFEf3ao4OwsQ
Date:   Mon, 25 Jan 2021 09:17:20 +0000
Message-ID: <MWHPR01MB24930A1C8795836B4659383D80BD9@MWHPR01MB2493.prod.exchangelabs.com>
References: <20201228020047.2283609-1-jason@os.amperecomputing.com>
In-Reply-To: <20201228020047.2283609-1-jason@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
x-originating-ip: [138.199.22.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00582fb6-88c2-46da-73ec-08d8c11204c2
x-ms-traffictypediagnostic: MWHPR0101MB3024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0101MB30244FB7E3C8C42A6670661E80BD9@MWHPR0101MB3024.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22CgT2VTLg6yY567hZ97Dqc6aH8CaNtha2FkwA0FYqL51VGuh5R8aN+nyitPxJGn03SXKN6k2tPSopBTmSiij+cNLI4JycSP0tTQkVot3qRvP8D3Qu7+i8PlRi5GTopzgzR25JpBFh3jmh1twhH+c7CEb0LzwUOscISnDmqBkBhWwJdj22zT32t96xN3Q5OICtPgmaQHQw/195UGXKLl+30+88DJjFFMf2rxdkXHvfJkpmG+NT/BNMIAUcdfgkn3uZhIPUZ4qVmUjusMNEBnsRpdJcIN3Iw69V42hRXWUxPiDxHej9cJvzHFvDcDevdqYeipLWpDtbstN1R/l08gp7zK4iknij5+W6SNUTXPgZI5zzN6g+dR408E/R25CM162lxPALuEwtJaiCfwDGcv2VecEHCfV0JWC3CuweLCnwY/skKe+B+GTqzmuZYHzZdMeeTXEbRC315Cwd7DAewsnhonU2w001tWsAkkpeA6I6l8otu9thQp24FK5CvHoeZrMqOuikKZkGQTze93+dRBeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39840400004)(7696005)(66446008)(8936002)(64756008)(66556008)(66476007)(6916009)(4326008)(71200400001)(9686003)(66946007)(8676002)(107886003)(55016002)(76116006)(54906003)(52536014)(33656002)(83380400001)(6506007)(53546011)(15650500001)(5660300002)(86362001)(478600001)(2906002)(26005)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1j4VHIwWMPZ2lfprNETWVBi+J2gtDoFcX+3bNfOFrYc/vgfICyIn2bY6LPHc?=
 =?us-ascii?Q?Za+2mXAeVixocY6b7OSDTilozXioIC3DqnIu86rq6aAvQCDxx+WUK+89nwPP?=
 =?us-ascii?Q?GWGpI4yrbvaWqE9jTKNaihHTUYjgsvI0e1I7go/ihQcHOyosP8bcnmaiky3M?=
 =?us-ascii?Q?GcT23CNgw+o8xbQFlkTAzVV05o0JAtm3vcj6IGqJaCM5XMXtggHr7lOtf4dQ?=
 =?us-ascii?Q?NPH99JtleFiz9cJ+MrkoC2lFpAJF4Dozc8+th4WfxneDNT+gGYW9oME+Cu+V?=
 =?us-ascii?Q?tXkPFssPm4WTgYX/LkjzACbV5OVDiAT7ssF1RlMatZww6AAetiJEfMmnzioD?=
 =?us-ascii?Q?PV8V9HKGQ4jKo3lPLa0p/cfnSRqrrVpOA5hpS67MPb33N4n11AMh9FvV1pgO?=
 =?us-ascii?Q?eOAJci/i7jNZfNQ6h5fGgSQ1Pu+Ph9J8aWAD3ZA+4Pw8l/pyUlBQeKo/084+?=
 =?us-ascii?Q?YPpGf7EhKrCJkD4JJtImpjhbd4rTlO5tUTBwsKOznvUq0rWWLIh0TcEIORrs?=
 =?us-ascii?Q?GyPLpdbo86R2D31QCPaZtHmv61UM6i+c6gN2AdQSr0hjUATDjO0Nau0ZKVSE?=
 =?us-ascii?Q?igsP5vsY6B3jMvCMJAfFLCp/XUsr97/9bCGWneiUBn1QobT+MvlADzOkhGi5?=
 =?us-ascii?Q?g9BMbwHHt58QbHNBcDarOqvXyOWcPpuiy7IJ5hIBR/qCar07woqAzD2ffKCs?=
 =?us-ascii?Q?4HO9MH2cp96eI+/JtP4j6CD8mUwDggMF2c9jacnD64jpXyzqpnrFgEOV/lqN?=
 =?us-ascii?Q?RqdGX59MMKmyQSMMZhIPqC3xI1sUJz86zFnkQANWOpQbucSFA2J+TYLRVhNi?=
 =?us-ascii?Q?l5vIenmyuv7/i0FXIM68N78C6os82n4SnHz64s6hw+UeX5qS9tpR8gchuHnf?=
 =?us-ascii?Q?WW6kyk/QeZvkSmVtlBn4PkkZyiqXd1l0fPLHefBhnukCwnRus/z16rxr3cxf?=
 =?us-ascii?Q?C/HyFTVUFPlxMn5W/YR5oagT0082VyRoVhK6sElTwgOIMjzn7BwzejNUdfGo?=
 =?us-ascii?Q?oBFIQWIgD8wi/kDPbXlIBUDTN9LBdhW6xbCB//x84rfItFMporwhudQ6Lo/t?=
 =?us-ascii?Q?Kj+s8V83?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00582fb6-88c2-46da-73ec-08d8c11204c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 09:17:20.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycd+oFqbRZdC+L/TytJ5t564h6KudV+j4msmtFxmpqM22IW4d/ZtwEOqFkTVEkooDz2IO61xiWT9I+Pe4yVbHWWetq3zpu0HPHHJixfZgyhZURYf8cf6LCWNH0FseAvx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Experts,

Can I get some comments from you?

Thanks
Jason


-----Original Message-----
From: Jason Tian OS <jason@os.amperecomputing.com>=20
Sent: Monday, December 28, 2020 10:01 AM
To: linux-kernel@vger.kernel.org
Cc: Frank Wang <zwang@amperecomputing.com>; Jason Tian OS <jason@os.amperec=
omputing.com>
Subject: [PATCH] ARM64: RAS: Update code to trace out more data for ARM pro=
cessor

The original arm_event trace code only traces out ARM processor error infor=
mation data. According to UEFI_2_8_A_Feb14 specification chapter N2.4.4, th=
e ARM processor error section includes several ARM processor error informat=
ion, several ARM processor context information and several vendor specific =
error information structures.

Add code to trace out all ARM processor context information and vendor spec=
ific error information with raw hex format.

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
---
 drivers/ras/ras.c       | 22 +++++++++++++++++++++-
 include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c index 3f3890732..a0a6b2f=
87 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -23,7 +23,27 @@ void log_non_standard_event(const uuid_le *sec_type, con=
st uuid_le *fru_id,
=20
 void log_arm_hw_error(struct cper_sec_proc_arm *err)  {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len;
+	u32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+
+	pei_len =3D sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err =3D (u8 *) err + sizeof(struct cper_sec_proc_arm);
+
+	ctx_len =3D sizeof(struct cper_arm_ctx_info) * err->context_info_num;
+	ctx_err =3D pei_err + sizeof(struct cper_arm_err_info) *
+		err->err_info_num;
+
+	vsei_len =3D err->section_length - (sizeof(struct cper_sec_proc_arm) +
+					  pei_len + ctx_len);
+	ven_err_data =3D ctx_err + sizeof(struct cper_arm_ctx_info) *
+					  err->context_info_num;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, vsei_len);
 }
=20
 static int __init ras_init(void)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index a07946=
32f..7b1082774 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,22 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+ #define APEIL "ARM Processor Err Info data len"
+ #define APEID "ARM Processor Err Info raw data"
+ #define APECIL "ARM Processor Err Context Info data len"
+ #define APECID "ARM Processor Err Context Info raw data"
+ #define VSEIL "Vendor Specific Err Info data len"
+ #define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
=20
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+		const u32 pei_len,
+		const u8 *ctx_err,
+		const u32 ctx_len,
+		const u8 *oem,
+		const u32 oem_len),
=20
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
=20
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +191,12 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
 	),
=20
 	TP_fast_assign(
@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
 			__entry->running_state =3D ~0;
 			__entry->psci_state =3D ~0;
 		}
+		__entry->pei_len =3D pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len =3D ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len =3D oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
 	),
=20
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
-		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; running sta=
te: %d; "
+		"PSCI state: %d; %s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		__entry->affinity, __entry->mpidr, __entry->midr,
+		__entry->running_state, __entry->psci_state,
+		APEIL, __entry->pei_len, APEID,
+		__print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		APECIL, __entry->ctx_len, APECID,
+		__print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		VSEIL, __entry->oem_len, VSEID,
+		__print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
=20
 /*
--
2.25.1

