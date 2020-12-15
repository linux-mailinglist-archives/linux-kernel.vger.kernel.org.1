Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA72DA7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLOGD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:03:26 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:9982
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgLOGDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:03:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9AdWQTADb3Wk5gyHdL4skq0hjDv7lW0PV09tCn/ivJDwriJy4qXqUCOHHO0Fjc9CS8qQzai0d0U4hmmSdaLAs6aEtG05bE8GTZo4EZqJmjHrGZqUqv7Kl8gzPqPHArJGu2TL1HNpUqzqvBlIiAUrWVlhFKIq27lWJtkaujT/Md9nGZLA8t3moELPi8Sg94Z3EALLKrNh3ui+jVwVZ1z646FeUurCMmZjVBSF1cxIfBeTDBizHvoVLkFNTT0BfWqq6Qnira2JmpEm1e7rtxvNZOQKSoFsZUMaqsdt/5+ZOTocQKGsO6qL7SUvn50I6ZIPFSOlluCci0rEWfasZKkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gev6y1Bqh4ZhoUfD5PJWd7MoaEKkoMCuhv9C4AfCLZo=;
 b=VH3G32iMKajJEY5JwGm7sb/oNiX1l6VD8fsn32WFrLKks/gA7syU6sCfzLbi1nOYQUmecvku6EklfSojhf0KhA0NDt63XXoyp6ny2U0bIrmwNrDPrmz0f73YMcl/lGAjwZeYIEeUztEkfzjNsx/9iW3u+oTWOR474XqqslaSMrjEUkpGYJHkSPoLv1ZaUGWXcEw5ND27NuH0qx2T8iF0mcRKc2NLF6NiiZe8q+6z2kE32D8ge1kZcH9dhRVL2Wra0yKJh4oBV2f8ZRlwNaulPMvbztwbEfE7wU3RssQYHE8LYXE+/G5/9Yekp1emes8wP1+fQ1t5rWWnxUQ6/JtzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gev6y1Bqh4ZhoUfD5PJWd7MoaEKkoMCuhv9C4AfCLZo=;
 b=mgU417io2EZu9BZLaz2I4oACzVWKe47qn2hx1LMItUZ/UllPQ55x6zCnuiQu48Xcw4ojS/h2u1igeMkVK0nJq++1WepSLq3n+FiD08oBSpit7pRFmyxjsgmqXAC+RwiHRhAL3l/OOQFBfgw+YBKTPjPyxt1vli9doRApJMnhqHs=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Tue, 15 Dec
 2020 06:02:35 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 06:02:35 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Topic: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Index: AQHW0hE5ErykXup8f0OHrdJAnR2K6an3m6wAgAAGMgCAAAmhAA==
Date:   Tue, 15 Dec 2020 06:02:35 +0000
Message-ID: <20201215060206.GB18223@b29397-desktop>
References: <20201214120344.26344-1-pawell@cadence.com>
 <20201215050528.GB2142@b29397-desktop>
 <BYAPR07MB5381FB3C8AF9039D8C30E8AFDDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5381FB3C8AF9039D8C30E8AFDDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 736fb4cd-fcea-4d6b-feaa-08d8a0bf04f2
x-ms-traffictypediagnostic: DBBPR04MB7515:
x-microsoft-antispam-prvs: <DBBPR04MB7515A114D30E1D493331B6C98BC60@DBBPR04MB7515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4Fvc6pDX0ezydosnUdjjdA0Nf0pSieOuDKv7rBd2ezuH64jDYn9Tvx7Ze/YEDCX5tuKrouyfL15dUCCmkHmN/pZSgR8t14qM0U184XVVZmV+TKfRieMuWgt6iNuGUHOMTPSQ6UG6Oh3wDL2wNeEqaknETtYx2dZH59Pjsgy9ve+vObyGnm21yHf/RDpt3lS3kAnZi+JMNupPIVROuWCwksFu/Fhoo3pLpRojqcM/6Zb6eiglwNbIRIt1uNMRtov9MStB1WNyLnvhgCb6Z6PaiPLiIoDl8adQzDCQhg7CLj4qiH9y9A8/W7F9r2DeUwqfBR7B9MAI+kheLHCzJ9YtymXAf+l3fQaWwHv5MzpThsinEdmwj8urHL26AxXNtNyUymkjkVhT3mB4X66aUhi+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(54906003)(66476007)(316002)(71200400001)(83380400001)(6506007)(33656002)(91956017)(8936002)(966005)(4326008)(186003)(26005)(86362001)(478600001)(30864003)(5660300002)(64756008)(8676002)(6916009)(9686003)(66946007)(6512007)(33716001)(66556008)(76116006)(2906002)(1076003)(53546011)(44832011)(6486002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DGA42vq0h9JRdwcEe9Mf3lmoaG63XZXXWAiDzn6DUr1/EGWegT05O1sF7/i/?=
 =?us-ascii?Q?BNI2/eRC33MuFZ94Z2tMg6znhbzNi5wQhnYqO8315KVdP3VYIrW7fL8Cq58A?=
 =?us-ascii?Q?9n7Eo7g3Z4X0HpFISNOuw/vbPbJWAizZgDCoCXXIQHrPWoj5XDgmx2uxko2N?=
 =?us-ascii?Q?+aL5tm9JHUmqjQQmLiEegDd0/+tLFTc5IXRrUpp/eD5njB+kdMawJ8bRkAcZ?=
 =?us-ascii?Q?yGUuiL3IYFbrQ/KclCbR5afGPUEgWijoezSaGtu7FG7R8LR7XBh4eBy9fSkO?=
 =?us-ascii?Q?3kLRkHHJ5qnUQNmOCck9i0lkZ/WmJqHtJJaon8RI8HLnDc4oUie67E9/susb?=
 =?us-ascii?Q?v+UYrb6e/y0n+TKbDNe0dfdaC0Z1ufm2VaJNX6bwh/ev0qXGtgaIsvTDUZAw?=
 =?us-ascii?Q?GLNzTSCpbh0aumvBdk3v5F17JDnV2XlU/fHMPblhYeNBIasWgkFbeLq4xL54?=
 =?us-ascii?Q?6BYRgBe66ODFUfs2zmUp6Gjm/HhaPTV7O9VvXzkYQSVPkcPUc1auqxlYWe8D?=
 =?us-ascii?Q?b0nBVqTTgvf1ovChLT9IEHx4YVCmOEdseZuehxVWoOzEbXWzByb8D2w53+Do?=
 =?us-ascii?Q?RfqAHUgGVaDKgCBhEwnaN5c1GN8F8bo7+ZW5qhLMqUaLDHzT2lbQ2RTH8oCU?=
 =?us-ascii?Q?QA+BUEII2FLYzexF0ScKsO87FzEczc9VnN0dKuM+qQtVjo8zsg+BZfbwanl+?=
 =?us-ascii?Q?mxh7FreYnFwvAuimLWPFwyOvIINnj4ZgwkmoSvK9qqtQ5oqRImBU8I8uULDk?=
 =?us-ascii?Q?eDPkvBGjOw3nkdO0rcQm26Bsuyzkptz5cmRjPezTaM1ulslckzhrl1wT981t?=
 =?us-ascii?Q?xqvV7jdBBXjMfkfsOaZNmr1bh3lL8lXa4a91MjQCkjNWcCvvd+q+ZR357pGU?=
 =?us-ascii?Q?6J3T59tLLPuZFR8oUKV72QjVE45WP3srq7/LUDcvRypvVpPgFwbbIqcqx58T?=
 =?us-ascii?Q?fNeBFEmjxlaFzRIgjVarIBAScx/twiKfoxBCGu/2BTZGxjM8wAtzcwTqIA6U?=
 =?us-ascii?Q?LenT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C7A5AEF8A8A8A4291159C11BBC584A9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736fb4cd-fcea-4d6b-feaa-08d8a0bf04f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 06:02:35.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpHGcF0R3dFvTtcFkemsNzdfklWNxrIXdOuqp1FOdR2fTEb6nhCLHT9Jfl7ADOvVVxpl+ZXfXYW4F7AAyfFbyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-15 05:27:38, Pawel Laszczak wrote:
> >
> >
> >On 20-12-14 13:03:44, Pawel Laszczak wrote:
> >> Patch fixes all sparse warnings in cdsnp driver.
> >>
> >> It fixes the following warnings:
> >> cdnsp-ring.c:1441: warning: incorrect type in assignment
> >> cdnsp-ring.c:1444: warning: restricted __le32 degrades to integer
> >> cdnsp-ring.c:2200: warning: dubious: x | !y
> >> cdnsp-gadget.c:501: warning: incorrect type in assignment
> >> cdnsp-gadget.c:504: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:507: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:508: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:509: warning: invalid assignment: |=3D
> >> cdnsp-gadget.c:510: warning: cast from restricted __le32
> >> cdnsp-gadget.c:558: warning: incorrect type in assignment
> >> cdnsp-gadget.c:561: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:570: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:1571: warning: incorrect type in argument 1
> >> cdnsp-gadget.c:1602: warning: restricted __le32 degrades to integer
> >> cdnsp-gadget.c:1760: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1762: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1763: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1764: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1765: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1766: warning: incorrect type in assignment
> >> cdnsp-gadget.c:1767: warning: incorrect type in assignment
> >> cdnsp-gadget.c:458: warning: cast truncates bits from constant value
> >>                     (ffffffff07ffffff becomes 7ffffff)
> >> cdnsp-gadget.c:666: warning: cast truncates bits from constant value
> >>                     (ffffffff07ffffff becomes 7ffffff)
> >> cdnsp-mem.c:762: warning: incorrect type in assignment
> >> cdnsp-mem.c:763: warning: incorrect type in assignment
> >> cdnsp-mem.c:928: warning: cast from restricted __le16
> >> cdnsp-mem.c:1187: warning: incorrect type in assignment
> >> cdnsp-mem.c:1191: warning: incorrect type in assignment
> >> cdnsp-ep0.c:142: warning: incorrect type in assignment
> >> cdnsp-ep0.c:144: warning: restricted __le32 degrades to integer
> >> cdnsp-ep0.c:147: warning: restricted __le32 degrades to integer
> >> cdnsp-ep0.c:148: warning: restricted __le32 degrades to integer
> >> cdnsp-ep0.c:179: warning: incorrect type in argument 1
> >> cdnsp-ep0.c:311: warning: incorrect type in argument 1
> >> cdnsp-ep0.c:469: warning: incorrect type in assignment
> >> cdnsp-trace.h:611:1: warning: cast from restricted __le32
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >
> >Hi Pawel,
> >
> >The Reported-by tag should be above your Sob tag, I will change it.
> >Except the patch reported build error by kernel test robot, I will apply
> >your other four patches after finishing the compile test.
> >
> >Peter
>=20
> Hi Peter,
>=20
> I'm going to fix the "usb: cdns3: Adds missing __iomem markers"  today.
> I haven't  seen any issue on ARCH=3Dparisc. Maybe it's some specific risc=
v arch issue.
>=20
> I believe that:
> [auto build test WARNING on next-20201211]
> [cannot apply to peter.chen-usb/ci-for-usb-next v5.10 v5.10-rc7 v5.10-rc6=
 v5.10]
>=20
> is not the problem. I based on  peter.chen-usb/for-usb-next.
>=20
> Also I can't open the url from kernel test robot report.
> Maybe there is some temporary issue with server.=20
>=20

Thanks for checking it, I have already pushed your other four patches.
Besides, there is still a build error issue for new cdns3 driver.

https://www.spinics.net/lists/linux-usb/msg206073.html

Peter
> Thanks,
> Pawel
>=20
> >> ---
> >>  drivers/usb/cdns3/cdnsp-debug.h  |  2 +-
> >>  drivers/usb/cdns3/cdnsp-ep0.c    | 13 ++++++-------
> >>  drivers/usb/cdns3/cdnsp-gadget.c | 24 +++++++++---------------
> >>  drivers/usb/cdns3/cdnsp-gadget.h | 13 +++++++------
> >>  drivers/usb/cdns3/cdnsp-mem.c    | 11 ++++++-----
> >>  drivers/usb/cdns3/cdnsp-ring.c   |  4 ++--
> >>  drivers/usb/cdns3/cdnsp-trace.h  |  2 +-
> >>  7 files changed, 32 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp=
-debug.h
> >> index d6345d4d2911..a8776df2d4e0 100644
> >> --- a/drivers/usb/cdns3/cdnsp-debug.h
> >> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> >> @@ -414,7 +414,7 @@ static inline const char *cdnsp_decode_slot_contex=
t(u32 info, u32 info2,
> >>  		s =3D "UNKNOWN speed";
> >>  	}
> >>
> >> -	ret =3D sprintf(str, "%s Ctx Entries %ld",
> >> +	ret =3D sprintf(str, "%s Ctx Entries %d",
> >>  		      s, (info & LAST_CTX_MASK) >> 27);
> >>
> >>  	ret +=3D sprintf(str + ret, " [Intr %ld] Addr %ld State %s",
> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-e=
p0.c
> >> index d55b59ed7381..e2b1bcb3f80e 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
> >> @@ -137,10 +137,8 @@ int cdnsp_status_stage(struct cdnsp_device *pdev)
> >>  	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> >>  }
> >>
> >> -static int cdnsp_w_index_to_ep_index(__le32  wIndex)
> >> +static int cdnsp_w_index_to_ep_index(u16 wIndex)
> >>  {
> >> -	wIndex =3D le32_to_cpu(wIndex);
> >> -
> >>  	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
> >>  		return 0;
> >>
> >> @@ -176,7 +174,8 @@ static int cdnsp_ep0_handle_status(struct cdnsp_de=
vice *pdev,
> >>  		 */
> >>  		return cdnsp_ep0_delegate_req(pdev, ctrl);
> >>  	case USB_RECIP_ENDPOINT:
> >> -		pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> >> +		ep_sts =3D cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex));
> >> +		pep =3D &pdev->eps[ep_sts];
> >>  		ep_sts =3D GET_EP_CTX_STATE(pep->out_ctx);
> >>
> >>  		/* check if endpoint is stalled */
> >> @@ -305,10 +304,10 @@ static int cdnsp_ep0_handle_feature_endpoint(str=
uct cdnsp_device *pdev,
> >>  					     int set)
> >>  {
> >>  	struct cdnsp_ep *pep;
> >> -	u32 wValue;
> >> +	u16 wValue;
> >>
> >>  	wValue =3D le16_to_cpu(ctrl->wValue);
> >> -	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> >> +	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wInde=
x))];
> >>
> >>  	switch (wValue) {
> >>  	case USB_ENDPOINT_HALT:
> >> @@ -435,7 +434,7 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev=
)
> >>  {
> >>  	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
> >>  	int ret =3D 0;
> >> -	__le16 len;
> >> +	u16 len;
> >>
> >>  	trace_cdnsp_ctrl_req(ctrl);
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdns=
p-gadget.c
> >> index 1668f72fdf30..f28f1508f049 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> >> @@ -491,7 +491,7 @@ static void cdnsp_invalidate_ep_events(struct cdns=
p_device *pdev,
> >>  	struct cdnsp_segment *segment;
> >>  	union cdnsp_trb *event;
> >>  	u32 cycle_state;
> >> -	__le32  data;
> >> +	u32  data;
> >>
> >>  	event =3D pdev->event_ring->dequeue;
> >>  	segment =3D pdev->event_ring->deq_seg;
> >> @@ -527,9 +527,9 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *=
pdev)
> >>  	dma_addr_t cmd_deq_dma;
> >>  	union cdnsp_trb *event;
> >>  	u32 cycle_state;
> >> -	__le32  flags;
> >>  	int ret, val;
> >>  	u64 cmd_dma;
> >> +	u32  flags;
> >>
> >>  	cmd_trb =3D pdev->cmd.command_trb;
> >>  	pdev->cmd.status =3D 0;
> >> @@ -1568,7 +1568,7 @@ static void cdnsp_get_ep_buffering(struct cdnsp_=
device *pdev,
> >>  		return;
> >>  	}
> >>
> >> -	endpoints =3D HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
> >> +	endpoints =3D HCS_ENDPOINTS(pdev->hcs_params1) / 2;
> >>
> >>  	/* Set to XBUF_TX_TAG_MASK_0 register. */
> >>  	reg +=3D XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
> >> @@ -1754,22 +1754,16 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev=
)
> >>  static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
> >>  {
> >>  	void __iomem *reg =3D &pdev->cap_regs->hc_capbase;
> >> -	struct cdnsp_rev_cap *rev_cap;
> >>
> >>  	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
> >> -	rev_cap =3D reg;
> >> -
> >> -	pdev->rev_cap.ctrl_revision =3D readl(&rev_cap->ctrl_revision);
> >> -	pdev->rev_cap.rtl_revision =3D readl(&rev_cap->rtl_revision);
> >> -	pdev->rev_cap.ep_supported =3D readl(&rev_cap->ep_supported);
> >> -	pdev->rev_cap.ext_cap =3D readl(&rev_cap->ext_cap);
> >> -	pdev->rev_cap.rx_buff_size =3D readl(&rev_cap->rx_buff_size);
> >> -	pdev->rev_cap.tx_buff_size =3D readl(&rev_cap->tx_buff_size);
> >> +	pdev->rev_cap  =3D reg;
> >>
> >>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
> >> -		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
> >> -		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
> >> -		 pdev->rev_cap.tx_buff_size);
> >> +		 readl(&pdev->rev_cap->ctrl_revision),
> >> +		 readl(&pdev->rev_cap->rtl_revision),
> >> +		 readl(&pdev->rev_cap->ep_supported),
> >> +		 readl(&pdev->rev_cap->rx_buff_size),
> >> +		 readl(&pdev->rev_cap->tx_buff_size));
> >>  }
> >>
> >>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdns=
p-gadget.h
> >> index 8eb1b85a08b4..6bbb26548c04 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> >> @@ -493,11 +493,12 @@ struct cdnsp_3xport_cap {
> >>  #define CDNSP_VER_1 0x00000000
> >>  #define CDNSP_VER_2 0x10000000
> >>
> >> -#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) ((pdev)->rev_cap.ep_supp=
orted & \
> >> -			  (BIT(ep_num) << ((dir) ? 0 : 16)))
> >> +#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) \
> >> +			 (readl(&(pdev)->rev_cap->ep_supported) & \
> >> +			 (BIT(ep_num) << ((dir) ? 0 : 16)))
> >>
> >>  /**
> >> - * struct cdnsp_rev_cap - controller capabilities .
> >> + * struct cdnsp_rev_cap - controller capabilities.
> >>   * @ext_cap: Header for RTL Revision Extended Capability.
> >>   * @rtl_revision: RTL revision.
> >>   * @rx_buff_size: Rx buffer sizes.
> >> @@ -594,7 +595,7 @@ struct cdnsp_slot_ctx {
> >>  #define DEV_SPEED		GENMASK(23, 20)
> >>  #define GET_DEV_SPEED(n)	(((n) & DEV_SPEED) >> 20)
> >>  /* Index of the last valid endpoint context in this device context - =
27:31. */
> >> -#define LAST_CTX_MASK		GENMASK(31, 27)
> >> +#define LAST_CTX_MASK		((unsigned int)GENMASK(31, 27))
> >>  #define LAST_CTX(p)		((p) << 27)
> >>  #define LAST_CTX_TO_EP_NUM(p)	(((p) >> 27) - 1)
> >>  #define SLOT_FLAG		BIT(0)
> >> @@ -1351,9 +1352,9 @@ struct cdnsp_port {
> >>   * @ir_set: Current interrupter register set.
> >>   * @port20_regs: Port 2.0 Peripheral Configuration Registers.
> >>   * @port3x_regs: USB3.x Port Peripheral Configuration Registers.
> >> + * @rev_cap: Controller Capabilities Registers.
> >>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
> >>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
> >> - * @rev_cap: Controller capability.
> >>   * @setup: Temporary buffer for setup packet.
> >>   * @ep0_preq: Internal allocated request used during enumeration.
> >>   * @ep0_stage: ep0 stage during enumeration process.
> >> @@ -1402,12 +1403,12 @@ struct cdnsp_device {
> >>  	struct	cdnsp_intr_reg __iomem *ir_set;
> >>  	struct cdnsp_20port_cap __iomem *port20_regs;
> >>  	struct cdnsp_3xport_cap __iomem *port3x_regs;
> >> +	struct cdnsp_rev_cap __iomem *rev_cap;
> >>
> >>  	/* Cached register copies of read-only CDNSP data */
> >>  	__u32 hcs_params1;
> >>  	__u32 hcs_params3;
> >>  	__u32 hcc_params;
> >> -	struct cdnsp_rev_cap rev_cap;
> >>  	/* Lock used in interrupt thread context. */
> >>  	spinlock_t lock;
> >>  	struct usb_ctrlrequest setup;
> >> diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-m=
em.c
> >> index 4c7d77fb097e..7a84e928710e 100644
> >> --- a/drivers/usb/cdns3/cdnsp-mem.c
> >> +++ b/drivers/usb/cdns3/cdnsp-mem.c
> >> @@ -759,8 +759,9 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp_=
device *pdev)
> >>
> >>  	port =3D DEV_PORT(pdev->active_port->port_num);
> >>  	slot_ctx->dev_port |=3D cpu_to_le32(port);
> >> -	slot_ctx->dev_state =3D (pdev->device_address & DEV_ADDR_MASK);
> >> -	ep0_ctx->tx_info =3D EP_AVG_TRB_LENGTH(0x8);
> >> +	slot_ctx->dev_state =3D cpu_to_le32((pdev->device_address &
> >> +					   DEV_ADDR_MASK));
> >> +	ep0_ctx->tx_info =3D cpu_to_le32(EP_AVG_TRB_LENGTH(0x8));
> >>  	ep0_ctx->ep_info2 =3D cpu_to_le32(EP_TYPE(CTRL_EP));
> >>  	ep0_ctx->ep_info2 |=3D cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
> >>  					 max_packets);
> >> @@ -925,7 +926,7 @@ static u32 cdnsp_get_max_esit_payload(struct usb_g=
adget *g,
> >>  	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
> >>  	if (g->speed >=3D USB_SPEED_SUPER_PLUS &&
> >>  	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
> >> -		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> >> +		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> >>  	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit =
*/
> >>  	else if (g->speed >=3D USB_SPEED_SUPER)
> >>  		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> >> @@ -1184,11 +1185,11 @@ static int cdnsp_setup_port_arrays(struct cdns=
p_device *pdev)
> >>
> >>  	trace_cdnsp_init("Found USB 2.0 ports and  USB 3.0 ports.");
> >>
> >> -	pdev->usb2_port.regs =3D (struct cdnsp_port_regs *)
> >> +	pdev->usb2_port.regs =3D (struct cdnsp_port_regs __iomem *)
> >>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> >>  				(pdev->usb2_port.port_num - 1));
> >>
> >> -	pdev->usb3_port.regs =3D (struct cdnsp_port_regs *)
> >> +	pdev->usb3_port.regs =3D (struct cdnsp_port_regs __iomem *)
> >>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> >>  				(pdev->usb3_port.port_num - 1));
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-=
ring.c
> >> index 874d9ff5406c..e15e13ba27dc 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ring.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> >> @@ -1432,7 +1432,7 @@ static bool cdnsp_handle_event(struct cdnsp_devi=
ce *pdev)
> >>  	unsigned int comp_code;
> >>  	union cdnsp_trb *event;
> >>  	bool update_ptrs =3D true;
> >> -	__le32 cycle_bit;
> >> +	u32 cycle_bit;
> >>  	int ret =3D 0;
> >>  	u32 flags;
> >>
> >> @@ -2198,7 +2198,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_devi=
ce *pdev,
> >>  	 * inverted in the first TDs isoc TRB.
> >>  	 */
> >>  	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> >> -		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
> >> +		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
> >>
> >>  	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
> >>  	for (i =3D 0; i < trbs_per_td; i++) {
> >> diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp=
-trace.h
> >> index b68e282464d2..a9de1daadf07 100644
> >> --- a/drivers/usb/cdns3/cdnsp-trace.h
> >> +++ b/drivers/usb/cdns3/cdnsp-trace.h
> >> @@ -620,7 +620,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_slot_ctx,
> >>  	TP_fast_assign(
> >>  		__entry->info =3D le32_to_cpu(ctx->dev_info);
> >>  		__entry->info2 =3D le32_to_cpu(ctx->dev_port);
> >> -		__entry->int_target =3D le64_to_cpu(ctx->int_target);
> >> +		__entry->int_target =3D le32_to_cpu(ctx->int_target);
> >>  		__entry->state =3D le32_to_cpu(ctx->dev_state);
> >>  	),
> >>  	TP_printk("%s", cdnsp_decode_slot_context(__entry->info,
> >> --
> >> 2.17.1
> >>
>=20
> --
>=20
> Regards
> Pawel Laszcak

--=20

Thanks,
Peter Chen=
