Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7427CA62
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbgI2MSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:18:43 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:19398
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729969AbgI2MSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2Z+c2V4R4huwMNBMgbWxevxzarBi5yMGgik8689ut0K78YLlznaFKxSCh0tbFdmPoUTBhSOds2AuWF4UiOcIAtSQneSQg6+gkQVPVKrUMyyuSQpyQJTC5idzCxiWWjsu2GJeBhlnNj0zDDbPJJtsM/3hoo9BOQysetHVq+rqoi12xSBeCYuO61fon0IA6yDP8yrW+tjPML3PBVzt/wEx9755NjDzSWtokGPBIHsS3V88QYvVcV5gZX6dJrCOvfr4PjJPYT//cJCuZCU+1Rzije8Vp04dUOr+F5s53yxmOVayiX8okvTE3JjxIq9Ri0/CpNqKiOpvLwEujQxi5Ccyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA1BX21cFK26eil0VeitXapqX39jRnMOgI3OctH63Ms=;
 b=ePw2rTP++5pwXj1QFWq9rA8Gw9Ene79iq8l0/efPD0bhoJlwotNhrmukShdCRHZouLe2pVbGbksE1m4Gb8Xx403tn3uUxve4XIFI2QvAXfl+yRtgCJZFhXjypZuoVszMuj/jeRLtBJz78dRd++3Be6VzWakBII3owi+P9SzvrWLqq1lKNY9Wtv99rCtC/HIEgW37L3XDLOGxv3qeVeLYkupd0TXcljMAxcx04rmUBTGDwfeL0i8iMFJmVRhn7xcns5PpZU+GXdryxx8aNr9FMQ+lcdhsMIyCrbU/Ix58aCs03vjus3CQ3SOZ5ijtVTsqaRvXEnc5Ha95Ir+ucEz2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA1BX21cFK26eil0VeitXapqX39jRnMOgI3OctH63Ms=;
 b=ahK30VuqjYd+fsiBVKIXKHqJwfhVSV3GWt/izqOgrm862TQ0y/4wrg0Fdau/IXTnAEfxxAkuKin2+oDHqSIOdTF7TY2Bdik65kPRpWmFQrbUIviifzH8WeIZWHj2egWkVPw5flqd2ejIqc6qrxHcinjp1KIxqbDmRhamPw+DrYA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4050.namprd13.prod.outlook.com (2603:10b6:5:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.20; Tue, 29 Sep
 2020 12:18:34 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 12:18:34 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v4 0/1] convert l2 cache dt bindings to YAML format
Date:   Tue, 29 Sep 2020 17:48:15 +0530
Message-Id: <1601381896-29716-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: SG2PR03CA0149.apcprd03.prod.outlook.com
 (2603:1096:4:c8::22) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR03CA0149.apcprd03.prod.outlook.com (2603:1096:4:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.20 via Frontend Transport; Tue, 29 Sep 2020 12:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c596193-eadd-413c-35c0-08d86471c889
X-MS-TrafficTypeDiagnostic: DM6PR13MB4050:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB40509BDDAA6B66225D8BDF3797320@DM6PR13MB4050.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pm/M4I0gGiNeXFzm2WlNMkRVxECufABEi3BQjjpd/HPS++6ri4iAZNTRxYZhx7fJUb8ysNvIor9J5HxUJ9MkOnnsa/wUmOyfWA13vk8gjsX3FUx+v7Mavl9HopkkEHCwtqKqx4KoM4BJD0RftVFXQ3MdGP5qQH9oeygafEjVIEu+KmKZGiQKOsA24rA4Gpis5h1nwCSUcHWxKe+ScSV1Nz0o5V5++qScvq47J714JAAadJ3YFZ6HUwY83DijUU8MoUFwkvz1vGGvNrn1vjZ9fySpm2ACtCpLwXRsYsO++9zBxfxRsaeUPLJL/8nTQjsvogg4VwbeUHWrsgTKSKcya+VAGtRiaALTJv38OEqzj2USTqu9JwIhF7QRa/K3ioHln4MRFJavwaeHWonYxIY0ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(346002)(366004)(376002)(8676002)(66476007)(66946007)(6506007)(966005)(66556008)(4326008)(107886003)(6486002)(83080400001)(52116002)(6916009)(83170400001)(83380400001)(316002)(2616005)(186003)(42882007)(26005)(36756003)(956004)(44832011)(6512007)(2906002)(478600001)(16526019)(6666004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RBEv0t01QITiuJ23O7lg3F7WujG6SgdqAqWymqk9QDrowVGSUZwcItzSKVAkk6+C0jZ/yzRNnPQ0dzVZ0HIG4XaL3rluSB55EEzGkudz1o/ONPfsgYojNrRh0Jxlmn1HuloHGHkIrz/zWOycqOfV+dioH15RdVAGNct3IFHJCW6LdbZAZINCNh4B0vE0HrN8AkC/tyc1fqQAlAEcxOT3sfT5GhFVB2JKDWpIdYtPcUBIE0Y0L7YHo50CwDdfZL5khyeNAmM4V7LcIpsMOhzCX6GZdRFhmi1bga4I2FF9myQhPHfv1YuWwkhZ+xMkdOpaPpjcAFi2ylnryhtpNILyKq6OSQIG8NZo1Vz9pDXYawtJvkuRGTbkjjYiij0v1JY5TDAi7CkPv4NimV1fyDhClVyXqC6PAiJPB1F7IHGTSkrdIaHcsAc5LZuGqIhzXIekiKbwDIOu8s41CB+iwci8BXGfOLb0NfCPHfnK/EuW797VmWdeIi75ck8sWBA9wVhuDb0wT19WSAuyY1gOS4n6GnPp/uWqt38BBqYkAe1BK5kF/G4mu9zlUyHOJm1RVYXP9+FIDa0AZpwRjWGLvTHXHqWRkjkSAYZ3QOiqUH2wcQRFgqGY8SIVBUlvmVXnEYz844eRJs+TdtxqtVXt4vh+7g==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c596193-eadd-413c-35c0-08d86471c889
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 12:18:33.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9toO3JtxrdcU91j/G+uAhoABQSCpZEsHuqk2T5cJ2sbH5TeQQPkC4DLwBkW4xwxyGgqkuBek1oiEq8Kya654iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is created and tested on top of mainline linux 
commit a1b8638ba132 ("Linux 5.9-rc7")
Reference log of "make dt_binding_check" is available here[1].

Just in case required, reference log of "make dt_binding_check"
without this patch is available here[2].

[1] https://paste.ubuntu.com/p/8TmWDZJs3g/
[2] https://paste.ubuntu.com/p/ys5XNn38VP/

Change History:
====================
V4:
-Incorporated changes as suggested by Rob Herring here[3]
 [3] https://lkml.org/lkml/2020/9/22/929
-Rebased patch on 5.9-rc7

V3:
-Incorporated changes as suggested by Rob Herring here[3]
 [3] https://lkml.org/lkml/2020/9/15/670
-Rebased patch on 5.9-rc5

V2:
-Fixed bot failure mentioned by Rob Herring
-Updated dt-schema and kernel as suggested

V1:
Base version

Sagar Kadam (1):
  dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 -----------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 98 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

-- 
2.7.4

