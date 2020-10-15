Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC83428EA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgJOBfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:35:20 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:23525
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732348AbgJOBfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb0fGHZGVi4sdD4nooRyuF+42En0esB1zusdTHZGgfS6sA6Ls1Af+NjIONA/4oMwEPG+YXSxX1HqSfRw65t6oya7EoNBYYWTRvGgCMv5vlZ0pPWM8MdQLU4+PVc5Md+66U8oyYaK8LoBtFIWr0vJ8S/99QAi2GBdq/iepdeSFhKditBwQfPauVn74YFkhNgccm4cb7UFv2dEHxVyAukPXYFynsoXb5TzCpKt8CxbVBZUPWR8hr8aXcpj4W+Q8EMq2pytK0f8iIsaqdF4BguJd884MfKvQwq8gypsRoFy0ZrP2fuogWMbzhROTAn6mW1cMtrIRtaDuGCXQ5IIdqM1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7dF4YO7qwxylGzgJqF8dPezxNMMyaYAJJR3Okc/2Qs=;
 b=OXDUfpXQAORiRq+wRY6Qg1q9vBmogxfh8Sq0Xpj7k2cGWO0sZNqa6ny/S9yqFAS1ZUNFZAnV4GCoMA0gxgEnP+THJNeiKHLIx9LfzDWZJixlSsmvTEo/6L/wmzX4CU5lqHb3u7ehDm2x06hsDraTOBJuh5A5I6tyDncfW8Ez45nlcoDl+jYZFJgdVS4tOpibclQwPlDqy8Jp4YWZPAqnNMCIMk2F3uHLwfPyIeM0zXZ60Unlvpugkm/6vqOFEqBqvCdVJjLlXfqVw2+wOsdRnuFEE1NYw8bMLwKTh05T1DVKYKgd6eyDVW3ji9eM//G5BPXJuz4i9Y7bOt1QvNpDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7dF4YO7qwxylGzgJqF8dPezxNMMyaYAJJR3Okc/2Qs=;
 b=G2W0ocyxhhWHRQwnRo0vwf6Kc8+Ehb5P9cnzig9zWyBY7XKJT1CWsi7jttHWkCqbBmvbF50F5+gDPXSSdabZ0e6xYF9zHmBLofbSZQXYqTmOhgLiPyL3lPkRKGPOr6P18YbLTc6MeeyPy+QvvoUvivShEWau45Mc0raXI+eKfd4=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB4239.eurprd04.prod.outlook.com (2603:10a6:803:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 01:35:13 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::e171:19c1:b07f:53db]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::e171:19c1:b07f:53db%7]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 01:35:13 +0000
Message-ID: <4172025486c3821ec063199041b0a92118e0cf4d.camel@nxp.com>
Subject: Re: [PATCH] firmware: imx: always export scu symbols
From:   Liu Ying <victor.liu@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Date:   Thu, 15 Oct 2020 09:33:10 +0800
In-Reply-To: <1602665834-29902-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1602665834-29902-1-git-send-email-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Thu, 15 Oct 2020 01:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81e7629f-8c5d-4fe7-f5e6-08d870aa8faf
X-MS-TrafficTypeDiagnostic: VI1PR04MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4239DC45F5806619E6ABF83698020@VI1PR04MB4239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3g907JX5URSHBEPW2hoWw/En2unqWhAQk/kNDCI1F27SVKTkivz0TD1RkySuL1BEHf/4Fuieq3pppu8FR86GopLZyh9FZwxYRRAamm9p0fMLbB7WYI3oZEZ8a7PHbTey+B/xsJIPA07vyZvOXy6SJVcc1fc6Q34RnS9Yiw3AN9ClWRyw4CTqCWAyeAaYsiGVldsFRlOJrR3fmoLnnvfEMnJCBVkQdZQDB7z5sOtvNWOsay1kI1UA1q7KsR48EFc2a83ObFpWN8IXtDIKDa3by0bFMH90dMRUy5khA5aCNrquPD4EEGqgBs0xn7+CTtUll5gZ5qZIU3XkS3QD56I01+/N/AuNDOSR8LCImLeu46VvfWmF9t4EaUNgl1/uQHK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(36756003)(186003)(6486002)(8676002)(66556008)(66476007)(2616005)(956004)(6512007)(66946007)(5660300002)(8936002)(316002)(6506007)(16526019)(26005)(478600001)(86362001)(52116002)(2906002)(83380400001)(4326008)(4001150100001)(34490700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bXaQInhYTyOO0o3+AkC6EYzL5JCYbwlskFqZ/utQICpvS06dszthcvrZ/IAZQ+dfigsdTyjOvLXHTT67F+FlqLj8pOYSeZtVLGfHoBc9AoEO05lgeM56Sr1TWgE0gu/b/8WWb6qQcY0p3rzJTgYi4wQmuTGaIrWBWeJc3Zxyeomol1OV5I5xvTqQz8r3mv5u/GT0Gghs1puPV7Lt+3pb/Eg/dBr30E7i4Zci2PHIKK7gasvvy/bBfA7GfSN7oAuWl+SNi9Nnf489oUtrgzkIDbs+G+qGGsj9cLqZA8AzV446eCghejn7RkOgU8sBdmhEkADM9bA3zZKo001cgorwG4y8PJ43hSIfLd+bKp4rp0YtIAM+UB8AxHNLNW1iRLdgNicv4EWcMZ7ahns91ds6BiYGgtbVj5zJSQnLz0bxlbKSzUy6DlkQI32fuPHcwReO6BgFJq6p8KUNuqTUYPCXsIdroqo3KjyiEayYRXT6uJ2aG6Iy+GFs5S378YL/oUST3ByC9+v5Qiu/5JLSuhhnwyq491tWkYoeNIrWoUXnUYK0T1aiygpoN/T/grrkJo12pNMg2pjiLrO8nmJ9HAsqMvmS0MTsm53tenGC2MmPA5LOL7JoZ86u3EM1iUEZ+NFVL5YWunbOOnZBbJ0wcx21zA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7629f-8c5d-4fe7-f5e6-08d870aa8faf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 01:35:13.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUPUbfo2aOA7vJ36KHFGoeFGFss8CLAefkC4YgddCwNjY05Ue7lFNX2baDskTqIzK2VbJaCCGO8ohfxQc3zj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Wed, 2020-10-14 at 16:57 +0800, Joakim Zhang wrote:
> From: Liu Ying <victor.liu@nxp.com>
> 
> Always export scu symbols for both SCU SoCs and non-SCU SoCs to avoid
> build error.

s/scu/SCU/

> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  include/linux/firmware/imx/ipc.h      | 15 +++++++++++++++
>  include/linux/firmware/imx/svc/misc.h | 23 +++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/ipc.h
> b/include/linux/firmware/imx/ipc.h
> index 891057434858..300fa253fc30 100644
> --- a/include/linux/firmware/imx/ipc.h
> +++ b/include/linux/firmware/imx/ipc.h
> @@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
>  	uint8_t func;
>  };
>  
> +#if IS_ENABLED(CONFIG_IMX_SCU)
>  /*
>   * This is an function to send an RPC message over an IPC channel.
>   * It is called by client-side SCFW API function shims.
> @@ -55,4 +56,18 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void
> *msg, bool have_resp);
>   * @return Returns an error code (0 = success, failed if < 0)
>   */
>  int imx_scu_get_handle(struct imx_sc_ipc **ipc);
> +
> +#else
> +static inline int
> +imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp)
> +{
> +	return -EIO;
> +}
> +
> +static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
> +{
> +	return -EIO;
> +}
> +#endif
> +
>  #endif /* _SC_IPC_H */
> diff --git a/include/linux/firmware/imx/svc/misc.h
> b/include/linux/firmware/imx/svc/misc.h
> index 031dd4d3c766..d255048f17de 100644
> --- a/include/linux/firmware/imx/svc/misc.h
> +++ b/include/linux/firmware/imx/svc/misc.h
> @@ -46,6 +46,7 @@ enum imx_misc_func {
>   * Control Functions
>   */
>  
> +#if IS_ENABLED(CONFIG_IMX_SCU)
>  int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
>  			    u8 ctrl, u32 val);
>  
> @@ -55,4 +56,26 @@ int imx_sc_misc_get_control(struct imx_sc_ipc
> *ipc, u32 resource,
>  int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
>  			bool enable, u64 phys_addr);
>  
> +#else
> +static inline int
> +imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
> +			u8 ctrl, u32 val)
> +{
> +	return -EIO;
> +}
> +
> +static inline int
> +imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> +			u8 ctrl, u32 *val)
> +{
> +	return -EIO;
> +}
> +
> +static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32
> resource,
> +				      bool enable, u64 phys_addr)
> +{
> +	return -EIO;
> +}
> +#endif
> +
>  #endif /* _SC_MISC_API_H */

This is done in our downstream tree. I did this because a downstream
display driver covers SoCs w/wo SCU. For upstream, I find the drivers
can be splited so that this is not needed.

Do you see any existing upstream driver covers SoCs w/wo SCU?
I think this can be introduced together with the first that kink of
driver.

-- 
 Liu Ying

