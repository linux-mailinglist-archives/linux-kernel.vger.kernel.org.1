Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2B28E76D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390877AbgJNTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:36:54 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:13670 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390802AbgJNTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:36:41 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EJOFvX031201;
        Wed, 14 Oct 2020 14:36:36 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x032h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:36:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPQ3Ti4QWVXd+PuFxGMr9OMo/KqlE4k13jOmY2OGVGH/zkiJjG2Inw5dWoQyhZvuSIDvZTXUp4WPOjHNCfiK+J+j9kqdP9vWXK1UjYW2fmVazr2T8D5HialwTkhw9wLT7dk4TgN5FS6GOA6wmCLXKJdfCq1lMYcVefJAz9Og/l9Adux+EtUshWZT9jjCpqhfQXoFUyZjm+e4Wbf/7OJi8VaKZ+KmgFYqMQcuK5h7e/C3uu2f87QGA5WqXZkZVnqt8Vs1OZ6K11yBeydXjUe8h1iWV5k6XC06+nR/TYCliKX3DeFk860/1D2RqHw2RlLXH135copOJ2i4cN+NGKXidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdEtOkJi2qkXvowfCYQgGTm+JVUmypDrTRD9uMLePIY=;
 b=YRn8mx3thCIDozmd74sdOXc4pZu0h7S2hsZgE2nV8MiLpui+RxEW0oSwg8KQ3Ccqg6cG8I+mFfggCPg+WU5iIzgP0jboWPBSy/7M3gKEnRTL1ONxn6FsrPpffteM9kaA2Dk15Vhl6ogkD/3ZoTygn6p4Bp0jl+fYYCOv/GAY/OmXqRy4MqKWhEMlQBpweCF8uvV2/30vE+t2c1/Ik7HCvgJpR+VsYOByzuNE5a2B657sQt/gzZzxnsO9ozF00Ix81onSIFKQazdcTeBs5h30SgLiTra/bAPnI9hSBesdTBCLX9hlK/nxdJsGaf3QDkFqw0lWSv08vn8EVgHnk1yXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdEtOkJi2qkXvowfCYQgGTm+JVUmypDrTRD9uMLePIY=;
 b=pWlh2as09jHpRYLKZqL7d/t0NsIKV0D18qX1B7zZaZ35QZQWOvUR4yqP7kp+O3MRdNmHopc0rHRcRQAGoPBkMgiitDpkMB1RkSmJnQmrkScFkhOlf2XKoa2EWesLstLHDLesWmFnaq92G2a9gcGgmgtZa1lav196HTvXaZXEEY8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3854.namprd04.prod.outlook.com
 (2603:10b6:805:48::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 19:36:34 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 19:36:34 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saravanak@google.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
Date:   Wed, 14 Oct 2020 14:36:12 -0500
Message-Id: <20201014193615.1045792-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 19:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 621f9e78-fb53-40b4-5903-08d87078759b
X-MS-TrafficTypeDiagnostic: SN6PR04MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB3854CBF9D0294F5A7A7562B387050@SN6PR04MB3854.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TraaKP7h8Bf1GF3WTWs8rYj/N6yYsvXZuc8rv2q2IsrczcwQ168elkcUzB1DbxXHuUL92OOT/vhSajs8HvGd3gOOd6/Y2rfm+vuQ9zJB5HczK3iydVg471AJbis9GIF4M+KTEBbYqdtN9KoYAx7eXpwHSLgVXbU+mJS/z5DeGrAFeTLckdrNgZWTH25+mbJ/TND1lPKjHviyQyrHbEcQDpywbXfEZyeSvvGZ+Jm0PF0mdKnICBBGYb1Fb1r+Fa2QMCkt2n5veyrzM7u10ql5VhenN5eIanfHf1NWlXK8FkoVeYEOU3Eb397QN25uA8KItXDEJw7CRCuDBx1kzlnpVA6Fi0uCuk+8UwXYeWsep7WP77I28zK+ld09+z9mJT9J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(186003)(16526019)(6506007)(2616005)(69590400008)(66946007)(83380400001)(86362001)(66476007)(66556008)(8936002)(6666004)(5660300002)(1076003)(36756003)(4326008)(6512007)(2906002)(478600001)(6486002)(44832011)(52116002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kqX/YlUhmSNleol/mG/CGIMVN4PgVhKCNiVzcaL6PTusoLadUlhe3yOoByc+qV4aAB28EhUYqNA4GWrYipmecb31weIQ6/DFxKfY0RGSy33AHL1lteeo/E4Ik0LXo/IE/9sDooXnAqyIcBXxeS+zq3f+IeP2rk7vE16QeylSAyzCL9vPXLPUU+AH2kkLj5xZbhoq1L7/OruqrWD4P/P5wEZhPH+kLoj3aJnguqEQe2/ATmw3INc5wcobpwTjd6NIymD/ujCqz+KN8EXEu6vXLN6ROM7RgkJ3zKm9IFPeyawW0ZOj/6K05Rsh6YrFSqLSroF6zbIwUojKp0Xm/IENWOcrEtslqeUOq+n6dA6EdW+4IRngRtbR2quJrl/yf5p3zqXLgcwdg4mbuGkvJ6Hm4atb02yvUYwoHZcE3rMa3JKtVjbZpZkIdv+sxXKbniCjDoqL8DvpyP9spQ/YZBvrhg7TdB02WlrvQPBXJsDcl7cNRa/rSXT/f5ygFT0wxAVbgSRn+8HbUNMKe+2v7VzTk11Bx7PD9n+iVtybWDwRtMtWnij/TdHh9CV+b/uU2Kye9kIZS8AcwAcua8fO1CUbEt91MWKwG71NynTlnrRHDnt0M4TfCt25pVB1ebe5CskHJwdtYj6ON18eTA5lbUEeb5w7NXSXrApW0dA3+o+M1uqkNnbm7dWCaigd86/pyXJ7Lx3zU7WFcNLamgdR2WNX8Q==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f9e78-fb53-40b4-5903-08d87078759b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 19:36:34.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o31ZvcIbqxXC5so1hhKfpKZkqNKySJrws3KACsfbfnp0hROZ5NwRs5XKEKvpz9afX7BHyYWXsX1KEaJuTfqiSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1011 suspectscore=2 adultscore=0 lowpriorityscore=0
 mlxlogscore=724 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After updating to v5.9, I've started seeing errors in the kernel log
when using device tree overlays. Specifically, the problem seems to
happen when removing a device tree overlay that contains two devices
with some dependency between them (e.g., a device that provides a clock
and a device that consumes that clock). Removing such an overlay results
in:

  OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
  OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy

followed by hitting some REFCOUNT_WARNs in refcount.c

In the first patch, I've included a unittest that can be used to
reproduce this when built with CONFIG_OF_UNITTEST [1].

I believe the issue is caused by the cleanup performed when releasing
the devlink device that's created to represent the dependency between
devices. The devlink device has references to the consumer and supplier
devices, which it drops in device_link_free; the devlink device's
release callback calls device_link_free via call_srcu.

When the overlay is being removed, all devices are removed, and
eventually the release callback for the devlink device run, and
schedules cleanup using call_srcu. Before device_link_free can and call
put_device on the consumer/supplier, the rest of the overlay removal
process runs, resulting in the error traces above.

Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
for any pending device_link_free's to execute before continuing on with
the removal process.

These patches resolve the issue, but probably not in the best way. In
particular, it seems strange to need to leak details of devlinks into
the device tree overlay code. So, I'd be curious to get some feedback or
hear any other ideas for how to resolve this issue.

Thanks,
 Michael

1. Note that this isn't a very good unit test: it will report a "pass"
   even if it fails with the aforementioned errors, as these errors
   aren't propogated.

Michael Auchter (3):
  of: unittest: add test of overlay with devlinks
  driver core: add device_links_barrier
  of: dynamic: add device links barrier before detach

 drivers/base/core.c                     | 10 ++++++++++
 drivers/of/dynamic.c                    |  3 +++
 drivers/of/unittest-data/Makefile       |  1 +
 drivers/of/unittest-data/overlay_16.dts | 26 +++++++++++++++++++++++++
 drivers/of/unittest.c                   | 16 +++++++++++++++
 include/linux/device.h                  |  1 +
 6 files changed, 57 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_16.dts

-- 
2.25.4

