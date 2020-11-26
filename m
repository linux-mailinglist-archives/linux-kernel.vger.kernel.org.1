Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909232C4EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbgKZGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:30:56 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:28705
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388010AbgKZGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE8RrvYkk0tYCsTUDxVRkLBH7IF/WXxV5vNPYKbPa+UVAp36dSR9GmjkaLNRhj1sWPG3ntUTCH0S8h+JVMe++utaquEKhJEAHbl7WRwwb/iTfcijFJiYGCK0TGSzaKASnnRg4U3JhCvGJJTqUsDEn+HCwQ0yNC8f7U+Ku6+HZB5OLWcZ4pIT21auwxsgJUjfdRaVx4a5xMd8/D7z3glov2+r2WRtwQAy+GfRy3NcmJjKDHx2edJaw2M7TpJpaAQoz2FxxQcgF937dA671rZwDfkkIGC0Ws1O778ccOxjeI7fZklSvmjmdinfXI4I8s6leeo5Tgs9KHih8IP4s8bApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2lfawqwMSgjo+fvXa2PHhK6IXuXMpu4ZTaIghaLdHc=;
 b=jyXrX6WGb0gI5lImVcS+fFJXqXN71dj7Y1nu09B2Y+EUWKbYugL6W68KbjezWsqrn0XWAHC0FN3BMz+8w8cqNN/23SPUC2oXp0fb+MOMR124xpFxl+FoV19PQdEBuVxRmoeBN9V+RS7mzBcinaxipdDWrfhmbBIhoN1y/lKxvtYbGXD1IFtlBMriPUjH9HAKHnsVKOSNsPm/c5dXjt1MYru9W/R5Qn6ZdTCYAe7atpiEUIN0S9zChRSumgrxHpBTcDxZ1036nyKBRidZostmNFy//o6/6/dMJgb2HGlczHfApfCWiB9RmHrraUxpaa/tVxJmL9gWMvyLvdszQvJ+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2lfawqwMSgjo+fvXa2PHhK6IXuXMpu4ZTaIghaLdHc=;
 b=idj3z0SsWr4mPNuiHbDb78Aghuu5+W6hCSDyo2l1cnCjdwQzsp9qZBQqtmDdikhl+2aX1yc+74iVkT65Kgl3xz8flFykOCFWPey0qLwZCE5EfXHU270lTuiIno1vZ+qEZuutJnRb6wwqm3wTIDWkd5RrNvYhn0BqK6ogZaFxNrE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2762.namprd11.prod.outlook.com (2603:10b6:5:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Thu, 26 Nov
 2020 06:30:54 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 06:30:53 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/3] clear_warn_once: add timed interval resetting
Date:   Thu, 26 Nov 2020 01:30:26 -0500
Message-Id: <20201126063029.2030-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hackbox.wrs.com (128.224.252.2) by YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 06:30:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4abc7762-b93e-4abf-f09c-08d891d4d35b
X-MS-TrafficTypeDiagnostic: DM6PR11MB2762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB27627001C94C1ECF6EC0400483F90@DM6PR11MB2762.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isWb4pjMimM56FIZDeaire4tGRo+nefgYH4aWb3eiuxRknaZx0Oy0Rd8n/Fmqrry7aGGLgL/t+TF6gU2dW5YTAGa1NwwgfuqrIwNURvIGErnP3ob/fr0dXUgOcWR0U6hLZZKUMPoc5h/o62AgGSRfU0W/gdNOjmwz8P5zFltVP5GPm37THIwhmOMQ8XNGUI678l8w8aDV7gb12Wp8GoeAn6Bn553qrs7tXnQdUVch369VDXpACdcO+Z8o9YO1O2/49tsXfziq/yy8A8xyEcCrBUpvdVlILQKEe3cbUxHWKQK7MY5NTiByuYl3aVS7wjV40r23fHPvd9eYZPgU8TJ/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(2616005)(66946007)(6666004)(66476007)(44832011)(6512007)(66556008)(478600001)(956004)(2906002)(4326008)(5660300002)(8936002)(8676002)(6506007)(54906003)(186003)(16526019)(1076003)(52116002)(316002)(6486002)(86362001)(6916009)(36756003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UoGwD9xatei711QaWOyMNYEdZiHvtkV+9+UU3VgylWQU0Uvpil8AwcxJt9X+?=
 =?us-ascii?Q?aq0Sd/QgN9Oi6PjHiX9ZfnHA3Oo1d9WquxceciprSJ5T0QLmk1MVgavhUyp2?=
 =?us-ascii?Q?yfnLlSD1Bp8sFVpwifsUWntMJ7zs3IHcSOOqbpCFBwyQ7QScduKrwxEpddhg?=
 =?us-ascii?Q?mjc9OXxc9P/QLWj1WqRPfg4pPm1hVq7n/fmgRAvLJnZhttlzlbPzUvnT2PAQ?=
 =?us-ascii?Q?HCIvSNtkYMavm3q/c1DW39V4773DokUQb3psX2BXqZ8HI3K6YAAHIgqCOxrK?=
 =?us-ascii?Q?pxrmzCSI9lg94iVHiltb6vqin86k/8RV/WAM112X7HG9LIAs3kHd4b55zkD8?=
 =?us-ascii?Q?8sl6OkLaaPDMrpX7PBSMZ24GVWiX++vu2mYgaUQcS0Z2narAqFjIndA2Gtgc?=
 =?us-ascii?Q?U0Q6jqqrJuSxwVm04acM49xzLouBlEt9vwSN7kDDelOY/RpcqwJKIr6fsg92?=
 =?us-ascii?Q?7JOygk1bc+LHREJoWl/L9qOcvnsfk54yhog6gJJRAOCh4T8E2tLx2zuCrdIO?=
 =?us-ascii?Q?87DQveA5R5iFggWgwn0oOreKeRfgTDe0MfVq2g4IgMtzoo/NKb+o1/d1cf5R?=
 =?us-ascii?Q?512M98NkNITIxTARog2CWopmdQ0WZb0//YUiRtWoxUBdGG3PK49DndX5GNP8?=
 =?us-ascii?Q?dT98jjnP4OOJP95CV/mOYmqtbcACmTrV6a0mfHI6ByerqQKYROX4eMjcMg2S?=
 =?us-ascii?Q?rre1TlcRuNvfXFRrebE5I//5R4IHEjKP6Pw0pjnDRGXWw/D0LIq8+SSWAnRw?=
 =?us-ascii?Q?evtf9X/tj5Q7BWA8jp0a/1oyEMAuXzicv4Wsg7m77PabQCw5Lo83yCB4iAwW?=
 =?us-ascii?Q?c3uQRY48bcLDCckVBvJGLsMRWg3sPS4S7uUUlnsUjdLW5s+6ixxQ4IWSCzdq?=
 =?us-ascii?Q?CpUr3RB0MByVybGBm/FYplrpeudjvAy6/qiFGcQ5coxSOYslY8znOUGUtWTa?=
 =?us-ascii?Q?FhUkP7i2J/0oNHm+3I7CotHaOsrvpLjOykMdiMh+7txSfQcRrQy4jVQaQ/OF?=
 =?us-ascii?Q?XMQy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc7762-b93e-4abf-f09c-08d891d4d35b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 06:30:53.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjpT9CzfFfoZYT8NGDCMFgQC6RE0HscwSwPrc7rqLb9yc0c3LbbYtxdkwOPtCVk78F+dSSFHtjnyOlvP4PgkUXlDv3osFvAjUgd4k7S8AH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing clear_warn_once functionality is currently a manually
issued state reset via the file /sys/kernel/debug/clear_warn_once when
debugfs is mounted.  The idea being that a developer would be running
some tests, like LTP or similar, and want to check reproducibility
without having to reboot.

But you currently can't make use of clear_warn_once unless you've got
debugfs enabled and mounted - which may not be desired by some people
in some deployment situations.

The functionality added here allows for periodic resets in addition to
the one-shot reset it already had.  Then we allow for a boot-time setting
of the periodic resets so it can be used even when debugfs isn't mounted.

By having a periodic reset, we also open the door for having the various
"once" functions act as long period ratelimited messages, where a sysadmin
can pick an hour or a day reset if they are facing an issue and are
wondering "did this just happen once, or am I only being informed once?"

Tested with DEBUG_FS_ALLOW_ALL and DEBUG_FS_ALLOW_NONE on an otherwise
defconfig.

---

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>

Paul Gortmaker (3):
  clear_warn_once: expand debugfs to include read support
  clear_warn_once: bind a timer to written reset value
  clear_warn_once: add a warn_once_reset= boot parameter

 .../admin-guide/clearing-warn-once.rst        |  9 +++
 .../admin-guide/kernel-parameters.txt         |  8 ++
 kernel/panic.c                                | 78 +++++++++++++++++--
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.25.1

