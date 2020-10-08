Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62469286E35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJHFkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:40:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgJHFkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:40:36 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MY60L-1jsdAo1wJ3-00YR6S; Thu, 08 Oct 2020 07:40:23 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 0/4] time namespace aware system boot time
Date:   Thu,  8 Oct 2020 07:39:40 +0200
Message-Id: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TX5yjHBOJhmdCrAGy/j4qpBDnig8Foi8mVvgCTYJLzufaENbaaz
 RIXDFAQLglsfd8pc1tLx/7j0UkikMHAKVULae/5qQMaPOT4MEsQU3eebMz9lbDgbO8GwQqn
 MlL55c4jJMLOe4opR+Xgx5jY98/pbc/s3k9LBX3bhTPh5u9MfOzszEMC+HOU5nouDI76E4m
 kyunT6bcpcQtldRfUcmZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+rfLbyX3/2k=:IfIVEl4+xsAfis1TkMl57m
 LUjMRbVP2mqRd2O3yVebBjL70EtFwRMfb2Wqtslw8S+IfQoBZwrpDt1dndwVSFWMRjg9ZCyla
 5EXZ/6kHNz/rMBbhRBng5eRy2hqO2CCZe6t5/pQNSa+plnPwZ9U00lcl5jA5MXVP/9T6gCBrn
 +mE2QSYhuEL7+nzdL6QCK0eWa2Bqy6eh3hi4PTjmiHOHCuukyAW8x3SCAIj5Yf1w1RhPSCUBN
 wBuf9NzvzR8Ee+vPwT7QNcLk9V2mIja5jueUjNHhkMrlM/D7/Gc+vWo9JMFq1Al8JfAChSLSi
 UbA/ts6IGlP3T12wiB+tXppoyQtPRgrN0p9/gAX/DXvVH8lz3Veo5AH4Q3QBBDJn0e2xvuOye
 AYV1+OvFKAdpb/WLjDF63xAiJCac2tSjYIatr6GmxbTFEI9tHxhDx+gLZD2Oq0bJOzBpDX8At
 lvZYYzZwYG0o7Ti1REkNU73gc98ate6fZ4StRsiOglPZRls2nNefscZk2j1Q2w1/emBymHUzb
 TNwGGb+Q5uencMiEWZ8V6SyOafUb58NPTkS18WwFBLClR1Q5Ffzi0onpcpL8vydofd6KSHlaa
 AF01yqg0QIXVKvEbWOPxp5pI7XWgXXFzkp+MKppXxjIUjmb331IUkeP2hsJUgmQwXu0g7rvB2
 PzRlCUBYOG8f5D6O62luIKWni4VfJ7F8T8Ri7e1mKZ4IeOkQn+Z7JbZ7HkzWH3ykyFdSP0xZy
 Rl9CHeqDyyVWhs9EQFJAiS1cBDHr3W9Y31p8lPQQNd6jQ6+c96bX46X+NYijNPOd1nIWa60jp
 3ia7qOBbQFZ7ZwetY/GdIraAyWEp8NJEoxRBlnYNm6JHplBHNFyFDiS3YsqRZT7ku8gfmXy/w
 LMHrvF0wfzuQerg2c7nw==
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

v2 Changes:
Fixed compile errors with TIME_NS not set in config
Reported-by: kernel test robot <lkp@intel.com>

Michael Weiß (4):
  timens: additional helper function to add boottime in nsec
  time: make getboottime64 aware of time namespace
  fs/proc: apply timens offset for start_boottime of processes
  selftests/timens: added selftest for /proc/stat btime

 fs/proc/array.c                         |  6 ++-
 include/linux/time_namespace.h          | 13 ++++++
 kernel/time/timekeeping.c               |  3 ++
 tools/testing/selftests/timens/procfs.c | 58 ++++++++++++++++++++++++-
 4 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.20.1

