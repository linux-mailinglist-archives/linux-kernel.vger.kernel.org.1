Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1E28E87B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgJNVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:41:50 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:34062 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgJNVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:41:50 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09ELZvpM031497;
        Wed, 14 Oct 2020 16:41:47 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x03c9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 16:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f32b7rZzO/tLW4yfJuExBI7WA0DOI27SbeQTlXSzBM8jB9RrrzNI6xcap/fZxkWGguGFLQiN9/YsGkdXtme8jSMVZTVGhrYsH0sDwxC/9G+rLU75o+HIe/1DzKjIwZVd7NsqIt9gfOf6PSM5FaeP6MM6+TQLsViSytpYD/0TmgHdwXDFoH6bPrDN/BlsCMcYUqAVRflnA7j0evzHMbbLk90J5tJm4+j7QX9mSM7Aelxl/93UZ13F5g+8v5UTkSvSpW8s/NpXZ7ohEoUcHdsx+Gn4yzYLkCZU4zqujS7Cv7Ab8i1u2pIeA5ZyPL5CeuBD6NVwYrvAAYqhx3Z2h0VVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjcTekYjT5bjPks4bHxa1KcKlbicguu9R4JBTagx0kQ=;
 b=LsHvaIsMayhzqEYWDpdk0lA6Vo6gR8ikRbxKh/T4jcwmNaQA9rZEHMJ0FvN36vsj7qzwRo9jFyWjKEUndLWBR05aPrgSo43g/FBGfF7ujt3skRA8UFfHPe9ZVumyIZoi9mxm2CdObi+0i9VJG3CHbxgLysqRni+fte4nuYdchWu11bnlIcTv7/t3e1JaGeCviVJdKA2qOeE1VlfwMAkGXe72hdn3cFVo/aFA4pvzF0uKsqKVPgqYTo87KW2IVtLo9vujYpORgkd14nMJC9qRu/LLHPUrxIOZuGzqyziqBff+GOTN4U4KGMf3v62B7AS8q1hiM1QoFSYJcuf+XkS6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjcTekYjT5bjPks4bHxa1KcKlbicguu9R4JBTagx0kQ=;
 b=UbG7ti1mxwIiR+eebpBFgsQsNgbaP94QqDKEtgsytFXTpcXAuarBA/Zg6Tq/IbtZhVnJwACBMYXBY0pOrvUGRWyKFdIs78qsm6aYDK+ANi1qT5wPw0jMT30ljeutPCU5jtWaNf/Hzbjy1kvYJ7NYuzwSgxTQx4YdFfzSG6YecDQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN2PR04MB2365.namprd04.prod.outlook.com
 (2603:10b6:804:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 21:41:44 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 21:41:44 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     srinivas.kandagatla@linaro.org, pantelis.antoniou@konsulko.com,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [PATCH 0/2] nvmem: add DT overlay support for cells
Date:   Wed, 14 Oct 2020 16:41:26 -0500
Message-Id: <20201014214128.1091738-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:4:4b::23) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR15CA0037.namprd15.prod.outlook.com (2603:10b6:4:4b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 21:41:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9498e80e-b996-471d-1dff-08d87089f1e3
X-MS-TrafficTypeDiagnostic: SN2PR04MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB2365C7C8D12B1F81D685646087050@SN2PR04MB2365.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKGhjubj7pN0/aXRNlYbZf5Ptho6/D6HCQAD+3M3fCFPtrg89WV59FgAsJYRWMtX2sjLeJ/ZP+4VjcR/fB8GS8e65w3JXx619q4qNcVP9q2yCrTmRs7RUqRunEiv/21JvOm7sSd3/uE5qcvVgjI2YS1rwiWt0zQipif0tBwETB6QgKUPnGmAkZiV79wW7Ek2y68zpXgaO7p/BhdOa6kSIpr+xtVVCvpiw8QjhGaIwDsvYj+hDK1yNlKFs+/VLXdfOznXfy38vNHruvnBxi5RtIt5IQuG1EOa1rWR1CgBjq19zU6ZArEMroYe70idQfAj/hPa9Cqqomub42dogTgt8KeYLmyljSmr8U/zrCHpSgZrn3VbD37abwwlhWpq8h+W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(4744005)(44832011)(5660300002)(6666004)(4326008)(316002)(6512007)(1076003)(2906002)(6486002)(8936002)(6506007)(186003)(16526019)(69590400008)(478600001)(36756003)(66476007)(52116002)(2616005)(83380400001)(66556008)(66946007)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: keRyiVeBkNuE1m0wyJgggwvj7cpRiWvmGfs8reNk5CJhLwn19aNzLaSk6tyhwEhAZ2qzwdj9fvzGqg7vdiD0A8m+KStEjok19FX7QDX2I2/5IWEu7klVuCXOJpOlltSzvB9w3L6/A4UwMVxcLMVqZzVhOm7yKLVe2hnqznQeoFVx7vEdTXZo6pSPvUNwix5ZBdCl4hlqYE9PFEPfkyTKToenViHgbligHWWxDYWzMRrt0nuSZFxX+Z1DSaBguJ/fDK02fzrtGBKq4f8xzPZT5ku0GHqNp9wg0/wio76wAO/W1prN5jY2lTByLUTGg1gdwfA64DE1BpvQkk3C4c1SmTYThil2LMUGQpKNVc/gTNAV1sk9K1dPbZpGmHXl8o89M/Pb0k2xNIRVQMK/5Wo7DwJKfsEScHn7dcYZoBxIKrtaPEa2/N6YkuTx48j0DmDYVFgv7ggn5fHdsxARMfla4I7VPNgXuj2YIuAKbcwwimTAO/3G8/3E47FRdUZrbdlaEqjM8UMGIdd4jh9SqU9OmzMapRjT9Dg14chSEl6vJVPSfUVsl9NV+IQicRee9JWGs71E+gt4rLsdPPNsTdM64q2zKkD5ZCV9fTB8JLDkdtcqa1o2awyfcOT1rYbFYuyy88QeheBTqd5fpKqFrLM7tOZcK4mKJyNUT8SA6Eu3m4uISslDwIKRejn2978rNlmARKiMzt3Q8sr0G+ETmfxwnQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9498e80e-b996-471d-1dff-08d87089f1e3
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 21:41:44.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgCdWS2ne+9JIE6Ojpj93y7q6lEPZs7we2/qF5bsCU+l22rIdsXB1N/TNJfz5VTVON78zW0ijU8LarlgK5QWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_12:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=616 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the ability to add/remove nvmem cells to an nvmem
device using device tree overlays. This can be useful in situations
where an nvmem device is present in the base device tree and the
specific overlay that's loaded knows how to interpret the data within
the nvmem device.

Michael Auchter (2):
  nvmem: core: extract function to add cell from OF
  nvmem: core: add OF_RECONFIG handler for nvmem cells

 drivers/nvmem/core.c | 149 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 39 deletions(-)

-- 
2.25.4

