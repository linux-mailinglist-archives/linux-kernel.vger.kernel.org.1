Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4E2DA755
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgLOFHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:07:10 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:53826
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgLOFGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:06:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFQEuTRT9oIqnmVU5RE2Y1jQAyH5OiQ5GekWPEqkz7LAeyjQdzXPBHL7EPOK7RSH2KviU8PhAAL5xt6kR8tQxeJbKdkeG08teWKNh+oATXQe1i0wRPi2fZ4ecDSlL1c+wq78kwX72ne1j8XlZT81v/VcfFd1YVplqAkvG4NIfD0z2jqilWJdjtSqzMOUd9LjaNpcUB6+cnJ02LsLt7Irv2TpVjXXMhsh3FG5bcEQdSKF4xt/pG07OMi0raCq5nYSnj1ykFeLlgaoI+Zo1ixSf279O1q/C9HnVkB5pqUE88SbA0CWek3Fpk0C73PE58XC29rIDR5RufEXJLV3aEQTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWeGVmbVLYAg94w4FIcx1m7d/Tv8CRoz5SAt/RxCSvU=;
 b=D/5sWkLQhc66L9FEgt4vxlMPQb9qyQww4Tz3tB/VdsDtFzWQkodGdRRsA6gwouukLwqX4enxkBvowQBHlH406Q95WmhcLHkd8F/PsjnJEb+3cjnHKDSuU/ife6VPt9gV3DDycn+iRfYqHxzHK3JXk/PV6pfrudRvk0a9ZV7sZjxItC2CuBNO7P27AA+TDOZTVQjAvv15WwJMUTWa45vjC+5YW1vVO4MnqTkoyW4dErRHKM/wZCBmL9Hx1EUHF5UPoBnF92Qw6i/2bn1Xa5AVulAVXd4C3t3KHRF6YCqft8yF5cQblxpI2BeHLraxqRT4/b59XkO5YL9sFr10pYwwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWeGVmbVLYAg94w4FIcx1m7d/Tv8CRoz5SAt/RxCSvU=;
 b=OcLvVFu5sXB/tljOslJcSAs/oGNaYuveEw1cL/KKneMeFRZqXyGpOve/9H0VRT3C7wW/Lwe3SISieiNns2NrylQ7gqYn9e+fSlJKapzeITVTDKzqwk43tyQ6x6qgrWivua2LgzfyoJdluVdjiytsSHUkEF8adi05Glabw5UV8p4=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 05:05:57 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 05:05:57 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Topic: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Index: AQHW0hE5ErykXup8f0OHrdJAnR2K6an3m6wA
Date:   Tue, 15 Dec 2020 05:05:57 +0000
Message-ID: <20201215050528.GB2142@b29397-desktop>
References: <20201214120344.26344-1-pawell@cadence.com>
In-Reply-To: <20201214120344.26344-1-pawell@cadence.com>
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
x-ms-office365-filtering-correlation-id: 3178d09f-f0f3-41c6-944a-08d8a0b71ba2
x-ms-traffictypediagnostic: DB7PR04MB5995:
x-microsoft-antispam-prvs: <DB7PR04MB5995FB72C0530900FA14D1988BC60@DB7PR04MB5995.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dT66GIRlgcIXPSONvHcm+EjClCIY2a+M8Ia4a7PnXVPiL/Zuv9kRZpZf8MMZT0o0qmj/RmVdIYqd190ptCWY6UUUEy1emYn60Co3lmwOY/dkMDcCHhzUxa0+pWpAENas2dRyGJh9yh2senRYB+E7nuF8HdIFlg4G/2BuBXOCY7IQAXE8k5DNBfYnxo66GXZ5jX52IgAUMIsCF6/gHedLFtXUgiPK3kS3C0+YtNYkxl9BZnUekmsJ+XSzcOJlO9hisRb6y2pNCE+pSgUfJu0EObgglq92GWA3cXpjzBTKV5iJQV4g0tCFLjb5oLBWAzhB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(66556008)(54906003)(53546011)(6512007)(91956017)(5660300002)(86362001)(9686003)(478600001)(6506007)(83380400001)(30864003)(71200400001)(33716001)(66476007)(8676002)(1076003)(8936002)(66446008)(64756008)(4326008)(6486002)(26005)(316002)(76116006)(2906002)(6916009)(66946007)(44832011)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FyXv6+7gtz/TuEgauH8ZCm9Fj+T15whSSDZvzujvTUWM5YbXF1aunnQ6wLjQ?=
 =?us-ascii?Q?KO4y7XLcK3E1ByJMWW1MP2+O8TKsCfn6SLibn778yZcc58MFFdvKb6zDomM/?=
 =?us-ascii?Q?xSGKnw2lukIQVuggNJCV03LVAmVxmL9DM/nUdzTc7CKsDg0cht4qgRUej9LQ?=
 =?us-ascii?Q?Mf5uZf3+4zo0MCbxv7o8QxSFOmRYkwdlQSKijTgk1FmkubqksISJn0HK6wgS?=
 =?us-ascii?Q?J3l5ZsxpbTKjbENpfHbPWD13pBEJ979lCVn5jrykLUE5hYYzU9G+TEU8zOIj?=
 =?us-ascii?Q?HzO4uFVJ2jGDIK/2+yxDXexvQzGSxTaWj16NfMzvRXyHukQYtzfgcQAa6eM3?=
 =?us-ascii?Q?iVJix9H49ObenqVbggRkKsWg3WNjf29GOnk726E9bXzn2RAoXPV/ceXlSprY?=
 =?us-ascii?Q?VfWhlYyfIi0nVNITTqf17nHkLJhoq0ETpCdcpphwvXB6bRQ74JpFigRtdGaa?=
 =?us-ascii?Q?0Vz/rNUjW+CpH6hQqQ7rHSbQWuotj0dZJH7Jtnub1xy5yxKIagp/aZLVPLRx?=
 =?us-ascii?Q?EAUkhe/ge5LFLEULuPPCClpcuoN60USrH3F8BPaRNXSkRs8Jr0FWsOwP48MW?=
 =?us-ascii?Q?UmKTHMycDshumbT20CAOIAsIU0GCkSfTbV1JjxDEx8Q//oio6iyLsUtm34HB?=
 =?us-ascii?Q?eanMPfQJ7wYxNgJrx4xlFnwNbheYajosd0AvN+/EcKjKYI2WRaQfzZXEM0g/?=
 =?us-ascii?Q?Lc7LFanQBtxhsuvW4hUaT7qEBzgX+oiIvYTuFU4QK4BVVHAlDFsiYY/VW+Pk?=
 =?us-ascii?Q?Iq6K25X+Rqwb/xGMhpECYP+H/FAJT/oaOjqnVYyFPnsqZ9D42T0GxJoWLU4n?=
 =?us-ascii?Q?v8SjzeBmRcMmSfqNgGZlUZn474Sih8tq8b7y5MllS5YZ/Xg+LN4k0B7+ZZo9?=
 =?us-ascii?Q?5UgdRuAAkNNUwZTcQ+xljAR36+MhIwTqKH8c0Vj7JA9ZtRjFqInLe7/tIpcE?=
 =?us-ascii?Q?F1Nae2ZYKXuQGFnNOg4vcy34CkDAvYj8TkH5n8CCvBRcMyixitbTcnoXm9OI?=
 =?us-ascii?Q?pjAL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A8BA95630189A489132C16C1D268D63@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3178d09f-f0f3-41c6-944a-08d8a0b71ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 05:05:57.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYQiifmJhxs1YvAHZxTeeCVHHvSNELyz93U5hiu4TZTureXlMi3Je+w14SuN4PRC2dS5TbzUxEyQ0t0b4DyFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-14 13:03:44, Pawel Laszczak wrote:
> Patch fixes all sparse warnings in cdsnp driver.
>=20
> It fixes the following warnings:
> cdnsp-ring.c:1441: warning: incorrect type in assignment
> cdnsp-ring.c:1444: warning: restricted __le32 degrades to integer
> cdnsp-ring.c:2200: warning: dubious: x | !y
> cdnsp-gadget.c:501: warning: incorrect type in assignment
> cdnsp-gadget.c:504: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:507: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:508: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:509: warning: invalid assignment: |=3D
> cdnsp-gadget.c:510: warning: cast from restricted __le32
> cdnsp-gadget.c:558: warning: incorrect type in assignment
> cdnsp-gadget.c:561: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:570: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:1571: warning: incorrect type in argument 1
> cdnsp-gadget.c:1602: warning: restricted __le32 degrades to integer
> cdnsp-gadget.c:1760: warning: incorrect type in assignment
> cdnsp-gadget.c:1762: warning: incorrect type in assignment
> cdnsp-gadget.c:1763: warning: incorrect type in assignment
> cdnsp-gadget.c:1764: warning: incorrect type in assignment
> cdnsp-gadget.c:1765: warning: incorrect type in assignment
> cdnsp-gadget.c:1766: warning: incorrect type in assignment
> cdnsp-gadget.c:1767: warning: incorrect type in assignment
> cdnsp-gadget.c:458: warning: cast truncates bits from constant value
>                     (ffffffff07ffffff becomes 7ffffff)
> cdnsp-gadget.c:666: warning: cast truncates bits from constant value
>                     (ffffffff07ffffff becomes 7ffffff)
> cdnsp-mem.c:762: warning: incorrect type in assignment
> cdnsp-mem.c:763: warning: incorrect type in assignment
> cdnsp-mem.c:928: warning: cast from restricted __le16
> cdnsp-mem.c:1187: warning: incorrect type in assignment
> cdnsp-mem.c:1191: warning: incorrect type in assignment
> cdnsp-ep0.c:142: warning: incorrect type in assignment
> cdnsp-ep0.c:144: warning: restricted __le32 degrades to integer
> cdnsp-ep0.c:147: warning: restricted __le32 degrades to integer
> cdnsp-ep0.c:148: warning: restricted __le32 degrades to integer
> cdnsp-ep0.c:179: warning: incorrect type in argument 1
> cdnsp-ep0.c:311: warning: incorrect type in argument 1
> cdnsp-ep0.c:469: warning: incorrect type in assignment
> cdnsp-trace.h:611:1: warning: cast from restricted __le32
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Reported-by: kernel test robot <lkp@intel.com>

Hi Pawel,

The Reported-by tag should be above your Sob tag, I will change it.
Except the patch reported build error by kernel test robot, I will apply
your other four patches after finishing the compile test.

Peter

> ---
>  drivers/usb/cdns3/cdnsp-debug.h  |  2 +-
>  drivers/usb/cdns3/cdnsp-ep0.c    | 13 ++++++-------
>  drivers/usb/cdns3/cdnsp-gadget.c | 24 +++++++++---------------
>  drivers/usb/cdns3/cdnsp-gadget.h | 13 +++++++------
>  drivers/usb/cdns3/cdnsp-mem.c    | 11 ++++++-----
>  drivers/usb/cdns3/cdnsp-ring.c   |  4 ++--
>  drivers/usb/cdns3/cdnsp-trace.h  |  2 +-
>  7 files changed, 32 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-de=
bug.h
> index d6345d4d2911..a8776df2d4e0 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -414,7 +414,7 @@ static inline const char *cdnsp_decode_slot_context(u=
32 info, u32 info2,
>  		s =3D "UNKNOWN speed";
>  	}
> =20
> -	ret =3D sprintf(str, "%s Ctx Entries %ld",
> +	ret =3D sprintf(str, "%s Ctx Entries %d",
>  		      s, (info & LAST_CTX_MASK) >> 27);
> =20
>  	ret +=3D sprintf(str + ret, " [Intr %ld] Addr %ld State %s",
> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.=
c
> index d55b59ed7381..e2b1bcb3f80e 100644
> --- a/drivers/usb/cdns3/cdnsp-ep0.c
> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
> @@ -137,10 +137,8 @@ int cdnsp_status_stage(struct cdnsp_device *pdev)
>  	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
>  }
> =20
> -static int cdnsp_w_index_to_ep_index(__le32  wIndex)
> +static int cdnsp_w_index_to_ep_index(u16 wIndex)
>  {
> -	wIndex =3D le32_to_cpu(wIndex);
> -
>  	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
>  		return 0;
> =20
> @@ -176,7 +174,8 @@ static int cdnsp_ep0_handle_status(struct cdnsp_devic=
e *pdev,
>  		 */
>  		return cdnsp_ep0_delegate_req(pdev, ctrl);
>  	case USB_RECIP_ENDPOINT:
> -		pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +		ep_sts =3D cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex));
> +		pep =3D &pdev->eps[ep_sts];
>  		ep_sts =3D GET_EP_CTX_STATE(pep->out_ctx);
> =20
>  		/* check if endpoint is stalled */
> @@ -305,10 +304,10 @@ static int cdnsp_ep0_handle_feature_endpoint(struct=
 cdnsp_device *pdev,
>  					     int set)
>  {
>  	struct cdnsp_ep *pep;
> -	u32 wValue;
> +	u16 wValue;
> =20
>  	wValue =3D le16_to_cpu(ctrl->wValue);
> -	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex))=
];
> =20
>  	switch (wValue) {
>  	case USB_ENDPOINT_HALT:
> @@ -435,7 +434,7 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
>  {
>  	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
>  	int ret =3D 0;
> -	__le16 len;
> +	u16 len;
> =20
>  	trace_cdnsp_ctrl_req(ctrl);
> =20
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-g=
adget.c
> index 1668f72fdf30..f28f1508f049 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -491,7 +491,7 @@ static void cdnsp_invalidate_ep_events(struct cdnsp_d=
evice *pdev,
>  	struct cdnsp_segment *segment;
>  	union cdnsp_trb *event;
>  	u32 cycle_state;
> -	__le32  data;
> +	u32  data;
> =20
>  	event =3D pdev->event_ring->dequeue;
>  	segment =3D pdev->event_ring->deq_seg;
> @@ -527,9 +527,9 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pde=
v)
>  	dma_addr_t cmd_deq_dma;
>  	union cdnsp_trb *event;
>  	u32 cycle_state;
> -	__le32  flags;
>  	int ret, val;
>  	u64 cmd_dma;
> +	u32  flags;
> =20
>  	cmd_trb =3D pdev->cmd.command_trb;
>  	pdev->cmd.status =3D 0;
> @@ -1568,7 +1568,7 @@ static void cdnsp_get_ep_buffering(struct cdnsp_dev=
ice *pdev,
>  		return;
>  	}
> =20
> -	endpoints =3D HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
> +	endpoints =3D HCS_ENDPOINTS(pdev->hcs_params1) / 2;
> =20
>  	/* Set to XBUF_TX_TAG_MASK_0 register. */
>  	reg +=3D XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
> @@ -1754,22 +1754,16 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev)
>  static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
>  {
>  	void __iomem *reg =3D &pdev->cap_regs->hc_capbase;
> -	struct cdnsp_rev_cap *rev_cap;
> =20
>  	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
> -	rev_cap =3D reg;
> -
> -	pdev->rev_cap.ctrl_revision =3D readl(&rev_cap->ctrl_revision);
> -	pdev->rev_cap.rtl_revision =3D readl(&rev_cap->rtl_revision);
> -	pdev->rev_cap.ep_supported =3D readl(&rev_cap->ep_supported);
> -	pdev->rev_cap.ext_cap =3D readl(&rev_cap->ext_cap);
> -	pdev->rev_cap.rx_buff_size =3D readl(&rev_cap->rx_buff_size);
> -	pdev->rev_cap.tx_buff_size =3D readl(&rev_cap->tx_buff_size);
> +	pdev->rev_cap  =3D reg;
> =20
>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
> -		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
> -		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
> -		 pdev->rev_cap.tx_buff_size);
> +		 readl(&pdev->rev_cap->ctrl_revision),
> +		 readl(&pdev->rev_cap->rtl_revision),
> +		 readl(&pdev->rev_cap->ep_supported),
> +		 readl(&pdev->rev_cap->rx_buff_size),
> +		 readl(&pdev->rev_cap->tx_buff_size));
>  }
> =20
>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-g=
adget.h
> index 8eb1b85a08b4..6bbb26548c04 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -493,11 +493,12 @@ struct cdnsp_3xport_cap {
>  #define CDNSP_VER_1 0x00000000
>  #define CDNSP_VER_2 0x10000000
> =20
> -#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) ((pdev)->rev_cap.ep_support=
ed & \
> -			  (BIT(ep_num) << ((dir) ? 0 : 16)))
> +#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) \
> +			 (readl(&(pdev)->rev_cap->ep_supported) & \
> +			 (BIT(ep_num) << ((dir) ? 0 : 16)))
> =20
>  /**
> - * struct cdnsp_rev_cap - controller capabilities .
> + * struct cdnsp_rev_cap - controller capabilities.
>   * @ext_cap: Header for RTL Revision Extended Capability.
>   * @rtl_revision: RTL revision.
>   * @rx_buff_size: Rx buffer sizes.
> @@ -594,7 +595,7 @@ struct cdnsp_slot_ctx {
>  #define DEV_SPEED		GENMASK(23, 20)
>  #define GET_DEV_SPEED(n)	(((n) & DEV_SPEED) >> 20)
>  /* Index of the last valid endpoint context in this device context - 27:=
31. */
> -#define LAST_CTX_MASK		GENMASK(31, 27)
> +#define LAST_CTX_MASK		((unsigned int)GENMASK(31, 27))
>  #define LAST_CTX(p)		((p) << 27)
>  #define LAST_CTX_TO_EP_NUM(p)	(((p) >> 27) - 1)
>  #define SLOT_FLAG		BIT(0)
> @@ -1351,9 +1352,9 @@ struct cdnsp_port {
>   * @ir_set: Current interrupter register set.
>   * @port20_regs: Port 2.0 Peripheral Configuration Registers.
>   * @port3x_regs: USB3.x Port Peripheral Configuration Registers.
> + * @rev_cap: Controller Capabilities Registers.
>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
> - * @rev_cap: Controller capability.
>   * @setup: Temporary buffer for setup packet.
>   * @ep0_preq: Internal allocated request used during enumeration.
>   * @ep0_stage: ep0 stage during enumeration process.
> @@ -1402,12 +1403,12 @@ struct cdnsp_device {
>  	struct	cdnsp_intr_reg __iomem *ir_set;
>  	struct cdnsp_20port_cap __iomem *port20_regs;
>  	struct cdnsp_3xport_cap __iomem *port3x_regs;
> +	struct cdnsp_rev_cap __iomem *rev_cap;
> =20
>  	/* Cached register copies of read-only CDNSP data */
>  	__u32 hcs_params1;
>  	__u32 hcs_params3;
>  	__u32 hcc_params;
> -	struct cdnsp_rev_cap rev_cap;
>  	/* Lock used in interrupt thread context. */
>  	spinlock_t lock;
>  	struct usb_ctrlrequest setup;
> diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.=
c
> index 4c7d77fb097e..7a84e928710e 100644
> --- a/drivers/usb/cdns3/cdnsp-mem.c
> +++ b/drivers/usb/cdns3/cdnsp-mem.c
> @@ -759,8 +759,9 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp_dev=
ice *pdev)
> =20
>  	port =3D DEV_PORT(pdev->active_port->port_num);
>  	slot_ctx->dev_port |=3D cpu_to_le32(port);
> -	slot_ctx->dev_state =3D (pdev->device_address & DEV_ADDR_MASK);
> -	ep0_ctx->tx_info =3D EP_AVG_TRB_LENGTH(0x8);
> +	slot_ctx->dev_state =3D cpu_to_le32((pdev->device_address &
> +					   DEV_ADDR_MASK));
> +	ep0_ctx->tx_info =3D cpu_to_le32(EP_AVG_TRB_LENGTH(0x8));
>  	ep0_ctx->ep_info2 =3D cpu_to_le32(EP_TYPE(CTRL_EP));
>  	ep0_ctx->ep_info2 |=3D cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
>  					 max_packets);
> @@ -925,7 +926,7 @@ static u32 cdnsp_get_max_esit_payload(struct usb_gadg=
et *g,
>  	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
>  	if (g->speed >=3D USB_SPEED_SUPER_PLUS &&
>  	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
> -		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> +		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
>  	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
>  	else if (g->speed >=3D USB_SPEED_SUPER)
>  		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> @@ -1184,11 +1185,11 @@ static int cdnsp_setup_port_arrays(struct cdnsp_d=
evice *pdev)
> =20
>  	trace_cdnsp_init("Found USB 2.0 ports and  USB 3.0 ports.");
> =20
> -	pdev->usb2_port.regs =3D (struct cdnsp_port_regs *)
> +	pdev->usb2_port.regs =3D (struct cdnsp_port_regs __iomem *)
>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
>  				(pdev->usb2_port.port_num - 1));
> =20
> -	pdev->usb3_port.regs =3D (struct cdnsp_port_regs *)
> +	pdev->usb3_port.regs =3D (struct cdnsp_port_regs __iomem *)
>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
>  				(pdev->usb3_port.port_num - 1));
> =20
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-rin=
g.c
> index 874d9ff5406c..e15e13ba27dc 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -1432,7 +1432,7 @@ static bool cdnsp_handle_event(struct cdnsp_device =
*pdev)
>  	unsigned int comp_code;
>  	union cdnsp_trb *event;
>  	bool update_ptrs =3D true;
> -	__le32 cycle_bit;
> +	u32 cycle_bit;
>  	int ret =3D 0;
>  	u32 flags;
> =20
> @@ -2198,7 +2198,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device =
*pdev,
>  	 * inverted in the first TDs isoc TRB.
>  	 */
>  	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> -		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
> +		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
> =20
>  	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
>  	for (i =3D 0; i < trbs_per_td; i++) {
> diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-tr=
ace.h
> index b68e282464d2..a9de1daadf07 100644
> --- a/drivers/usb/cdns3/cdnsp-trace.h
> +++ b/drivers/usb/cdns3/cdnsp-trace.h
> @@ -620,7 +620,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_slot_ctx,
>  	TP_fast_assign(
>  		__entry->info =3D le32_to_cpu(ctx->dev_info);
>  		__entry->info2 =3D le32_to_cpu(ctx->dev_port);
> -		__entry->int_target =3D le64_to_cpu(ctx->int_target);
> +		__entry->int_target =3D le32_to_cpu(ctx->int_target);
>  		__entry->state =3D le32_to_cpu(ctx->dev_state);
>  	),
>  	TP_printk("%s", cdnsp_decode_slot_context(__entry->info,
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
