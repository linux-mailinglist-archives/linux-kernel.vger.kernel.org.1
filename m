Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133192868BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgJGUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:01:05 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:01:05 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbTCr-1kxed23NY9-00bvOl; Wed, 07 Oct 2020 22:00:53 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 0/4] time namespace aware system boot time
Date:   Wed,  7 Oct 2020 22:00:11 +0200
Message-Id: <20201007200015.30868-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zGcyDUSXTEyWSTToW2A6PEEgEE5iLfqToJYq0UJsJ9GwYyyw6ro
 EAZfUtMTdO4NC8flui2cao8kl3N7SuhYCiVBc2t53JAFW77ZFiI1hNJ8F493+/Nno6nqnC0
 S8EzWcZOCXyLTCyYWowqxYDplKRDH5KykKZrRGuPAlP4k1TmzruHBqA9kR1pHjuYWVRmgjM
 01v00OEBKqrt95yDYgC0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e8DEi4Bowt4=:8/CdMWvEjyOxPSFhLLzlLH
 BqJ0kggo/v1dZ1ZDTM3Dv8v7s/iO39iG7kDfDVYbxuu3oQQ2YlXW63c0MfT2rUpr6QPdj9JBL
 EGcl1mr1GgI3gxac3LsgkExBwO/wTAqoUQmECVKO2Q5itfvMiJ0mHwJ3Szbd4aMzs8R7gcKA9
 4jZGwu+VWWIWYrSoJb3IGsfzpECqPCrGDx9ylvZyxf3/y8/nzPWNg9MqVNS23Id9183OsUrhq
 GX9pRd+2W3hPW0A3u/4q69InLKWX7ijxSvp1t93FCi9hiuzUuCzv1pGpiuGJdJCRuBxGXfX7v
 P4dEIbvZfMxjk34AQ3a41yVXWLFK74e7rQz03OVTDiOZceEjwWFpQkQjOd+OkOix4Oq8fg2Mo
 P15R7NVFzDdapQO3LOHGipi8OWIVk0GuHs1NFktKppt/Wsap9LSZ5Jy45vncIb2BTG/QJ3KFP
 ghWX2F88oYuxa4FoZcDSSsRPldTpgfim6T1JrwUiZyk3cX8yRKsZal26vql28VLWNdQhZ+nFv
 2C5dqxszRDL/k8xkoA7TxgwWEwSVIUBRKmfFx4J7BQJPLkwJp5ZA8yBmx3wRuF7/S6Ut/n2tM
 TileoaQ8UjLeALwIcFVT31zBel7g/NiMQecDQRtDUznHGkOCU5VES2oNLeWWrSRrOXZILiwou
 zI9cj8kAsXSMRpS2yVfLlHUToh/+n8zpdpZ2B0usj5Xtw36OsSNRBFV3NKwcgA65z5rb20VEI
 JP+lEv00xw4INKRVlCp6yW3Nrq3Tk1eUUCYwLby7/C5dcqoA/MGzOmV7XbEuVmdTsnL1Cqcbq
 gTlLL8DplwjRZkY2Dq3KX5IBZ+mfoRwK5vnAVDdp9JbOXiu/1N/fnfuG2d8D3qAI2QgiDY+ir
 JFRkwcd4k1/hCitAzxuw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time namespaces make it possible to virtualize time inside of
containers, e.g., it is feasible to reset the uptime of a container
to zero by setting the time namespace offset for boottime to the
negated current value of the CLOCK_BOOTTIME.

However, the boot time stamp provided by getboottime64() does not
take care of time namespaces. The resulting boot time stamp 'btime'
provided by /proc/stat does not show a plausible time stamp inside
the time namespace of a container.

We address this by shifting the value returned by getboottime64()
by subtracting the boottime offset of the time namespace.
(A selftest to check the expected /proc/stat 'btime' inside the
namespace is provided.)

Further, to avoid to show processes as time travelers inside of the
time namespace the boottime offset then needs to be added to the
start_bootime provided by the task_struct.

Michael Weiß (4):
  timens: additional helper function to add boottime in nsec
  time: make getboottime64 aware of time namespace
  fs/proc: apply timens offset for start_boottime of processes
  selftests/timens: added selftest for /proc/stat btime

 fs/proc/array.c                         |  6 ++-
 include/linux/time_namespace.h          |  7 +++
 kernel/time/timekeeping.c               |  3 ++
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 3 deletions(-)

-- 
2.20.1

