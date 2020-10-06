Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1D284EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:29:53 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:35808
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgJFP3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD3MMbx4YgMbAOp1eCel+Dc/wuyE5/ZRUFUIfez9pz2Ze1V8/UBbUr9d92L6P6V09MFYFK/OZbXYg9Pn+8/vlNgsOGZSyTOqZTpuWuOeW2rrRILcao0n7nhWbPWbqjn+TqbZG/QtBodobTJeeu5Hr2j6lcziBpGwEgYeB5qiGnfIB+BN769YqUdwJUH4EwGHLGHSLj96DgDgqL5VRDL94x7xQFAbcSEJ0O75EIVcIg68idRasrMuiKn6V2VqLYbRGnnMibyjXtcwbK+Cve4geYaw1UTBJ8fP6Q2MyCkG5OYwG3qxMki8Rt0Zt+c1Nv9XFVgH/6gwDAdeYC2DqnQVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmG7bqspEfRmO/bmIZMo3zun8Nn7oroANJaM11tkM5k=;
 b=Na7AZ3uMn/DaRCapuz6fLIhEy76hDkeVe2NUTmMfsE/tqmFFOPc5H+kqxfBl/vU0DM9nGdDEHcUtTLzcsqyp/kjBZU65vHvZCiVAuw9BLp3yDQTAx5nvxlHDXJaCROMfJCzXLTm8hgXqk+LQOUYeIJbkanp4Ju55i2+HcIi13Gd+PulgjJPOCtDWhv2/dmVUNPDnycPRw5GfuKGmXOeHqRh1HicFuXKB9lU7CT752F9fBkfiZX7aIHtnwu1MU7lrXPBzRsDEsJUUKKaE5/+OAoWm/rLabTtkrF2pAvTRP6mrwelADFVvqpe6SPScSbRV7QJq5IJVKtyTMnH1AvqU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmG7bqspEfRmO/bmIZMo3zun8Nn7oroANJaM11tkM5k=;
 b=Pg6wZCkw/ITmDi9mRAlp/qzeujVZPYIv0yec+oWi/HN7gECaBa1aCTymVnJ8OqKcX5PcWDuy9BZaIlxlhOImADWgs73JfxBQbBcHpgfFy2D9D6kjmVaj+cn6scAo/gUXLav2JoYxNP9oLXyikIXBIJEgFmUAOP1WUz9sDL6MTz4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Tue, 6 Oct
 2020 15:29:50 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 15:29:50 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH] dt: writing-schema: Fix indentation of items
Date:   Tue,  6 Oct 2020 17:29:37 +0200
Message-Id: <20201006152937.705746-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: PR0P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::24) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.home (82.67.86.106) by PR0P264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Tue, 6 Oct 2020 15:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5317fc20-071e-413e-8983-08d86a0caa5d
X-MS-TrafficTypeDiagnostic: SA0PR11MB4736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB4736E030912AB963B047C745930D0@SA0PR11MB4736.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSYRP3o0yXfN2TbRgVtmN/lZvFFP7XJ37qlJnLm+72Kicevg8AIxIgwCKNszCM8h/7bshyH5n0ytYtvaPCmshPeXlfX0ofuBM2GVXB4XS9lr1iS8mK4EMdPN9GLB08lANm9uNLaDtSrW8v81IUzDzvhJyxWLCCOqadPU1tZOuuqw3fkSfZM11arlodSA98ZI68NOWFP5z7VVdQiG2lqxbJ/qN+OCPvW86GxphDuWoQ+KEXG9K62y7nvXJmav31ZhB5OiyP3ib/jbZyAfTkGMNFpJV7FczO5B+dpY/qoVeYJknyNFIgURDwXLCI/dGX4Fi7+1ygmPpvNF26jttpNeow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(136003)(346002)(396003)(366004)(86362001)(66946007)(66476007)(66556008)(8936002)(16526019)(83380400001)(66574015)(52116002)(186003)(4326008)(2906002)(6506007)(26005)(316002)(2616005)(6486002)(8886007)(107886003)(8676002)(6666004)(5660300002)(478600001)(36756003)(54906003)(6512007)(956004)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pcMm2t8qoiQQoQ2nf43MO6QJac2mSFUjE9WdpThm9F8U54QiiQaFtqXk3tYCNYTlEHYsddxn6N1uWDe/dPp2921l9oTxUz7xCDQYSlG9+iVeAtCfMBxxtl0dV6wG0mW9Bzs7g21LpX9vMwjc+QgOd1spkx51m01GGozz5lwUJ78SSf6EbMjJvTpkWpQj87+/og7zw+bj/HmN1tpP6YNgXGL9djH/Nei1lztEICnGHVmZVnOHcvIBjvA8IrN8KUeI757iKNOtsvSrzNu8VDwUc9xhWnjMa1KjJ+QgDKtA3sWokmkYWnObYhPDoaPTP8FTQx9QyO+zo3kg0KtruQtEzwMLJxdGVTemQuKRj0D5mGZUBYZoPkxkuXt2D8SS6wxM14NzwqY5YUNbJ0GMwob4yvV3XCj2q9FZMXBB1JV6/fN+wkivQuPQ0WXkCgJ5iC1MvAm9gjOo8+u4prjvHLv8rCVKrZAN6NiS2ETo1qwQixe8u9cvqfxv/viM1AvKiMy99jz+mFAy9dnfK9Kr53owBF33Je6GSWMVdcpu+vtGpVfxQKf/dVjmzr2/GH6rOBYHgYD2A1pzZoPKmKoUA8s8B7p/FVzbDiJ2ejiJrsKohCJ9yv5GdM9JHnzQiMckImPGUr8UC6W9WTGjhfgCJAUUfg==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5317fc20-071e-413e-8983-08d86a0caa5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 15:29:50.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMBqWhYbZHAmgjyquURXyrrAnpEE2byJeUpD6kSS3lj7n5tnD8ykiY5o01bIuK1mXpsRDFhrz7p1irjYLaU2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IGl0ZW1zICdhbGxPZicgYW5kICdwcm9wZXJ0aWVzJyBhcmUgaW5kZW50ZWQgd2l0aCBvbmUgc3Bh
Y2UuIFRoaXMKY2hhbmdlIGFzIGJlZW4gaW50cm9kdWNlZCBpbiBjb21taXQgY2RlYTAxMjFhZTgw
ICgiZG9jczoKd3JpdGluZy1zY2hlbWEubWQ6IGNvbnZlcnQgZnJvbSBtYXJrZG93biB0byBSZVNU
IikgYW5kIGl0IHByb2R1Y2VzIHdlaXJkCnJlc3VsdHMgaW4gSHRtbCBhbmQgUGRmIG91dHB1dHMu
CgpPYnZpb3VzbHksIHRoaXMgZXh0cmEgaW5kZW50YXRpb24gd2FzIHVuYXR0ZW5kZWQuCgpGaXhl
czogY2RlYTAxMjFhZTgwICgiZG9jczogd3JpdGluZy1zY2hlbWEubWQ6IGNvbnZlcnQgZnJvbSBt
YXJrZG93biB0byBSZVNUIikKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9t
ZS5wb3VpbGxlckBzaWxhYnMuY29tPgotLS0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS93cml0
aW5nLXNjaGVtYS5yc3QgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL3dy
aXRpbmctc2NoZW1hLnJzdCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS93cml0aW5nLXNjaGVt
YS5yc3QKaW5kZXggMTZmMjFlMTgyZmY2Li4wM2UyNzlkOGZkNmEgMTAwNjQ0Ci0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS93cml0aW5nLXNjaGVtYS5yc3QKKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL3dyaXRpbmctc2NoZW1hLnJzdApAQCAtNDYsMTIgKzQ2LDEyIEBAIHNlbGVj
dAogICBzY2hlbWEuIEJ5IGRlZmF1bHQgd2l0aG91dCAnc2VsZWN0Jywgbm9kZXMgYXJlIG1hdGNo
ZWQgYWdhaW5zdCB0aGVpciBwb3NzaWJsZQogICBjb21wYXRpYmxlIHN0cmluZyB2YWx1ZXMgb3Ig
bm9kZSBuYW1lLiBNb3N0IGJpbmRpbmdzIHNob3VsZCBub3QgbmVlZCBzZWxlY3QuCiAKLSBhbGxP
ZgorYWxsT2YKICAgT3B0aW9uYWwuIEEgbGlzdCBvZiBvdGhlciBzY2hlbWFzIHRvIGluY2x1ZGUu
IFRoaXMgaXMgdXNlZCB0bwogICBpbmNsdWRlIG90aGVyIHNjaGVtYXMgdGhlIGJpbmRpbmcgY29u
Zm9ybXMgdG8uIFRoaXMgbWF5IGJlIHNjaGVtYXMgZm9yIGEKICAgcGFydGljdWxhciBjbGFzcyBv
ZiBkZXZpY2VzIHN1Y2ggYXMgSTJDIG9yIFNQSSBjb250cm9sbGVycy4KIAotIHByb3BlcnRpZXMK
K3Byb3BlcnRpZXMKICAgQSBzZXQgb2Ygc3ViLXNjaGVtYSBkZWZpbmluZyBhbGwgdGhlIERUIHBy
b3BlcnRpZXMgZm9yIHRoZQogICBiaW5kaW5nLiBUaGUgZXhhY3Qgc2NoZW1hIHN5bnRheCBkZXBl
bmRzIG9uIHdoZXRoZXIgcHJvcGVydGllcyBhcmUga25vd24sCiAgIGNvbW1vbiBwcm9wZXJ0aWVz
IChlLmcuICdpbnRlcnJ1cHRzJykgb3IgYXJlIGJpbmRpbmcvdmVuZG9yIHNwZWNpZmljIHByb3Bl
cnRpZXMuCi0tIAoyLjI4LjAKCg==
