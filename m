Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB741D2B75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgENJas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 05:30:48 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44790 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:30:47 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 14 May 2020 18:30:45 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: changjoon.lee@lge.com
Received: from unknown (HELO MacBookPro.local.net) (10.157.161.30)
        by 156.147.1.125 with ESMTP; 14 May 2020 18:30:45 +0900
X-Original-SENDERIP: 10.157.161.30
X-Original-MAILFROM: changjoon.lee@lge.com
From:   changjoon.lee@lge.com
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, ChangJoon Lee <changjoon.lee@lge.com>
Subject: [PATCH v2 0/1] Documentation update
Date:   Thu, 14 May 2020 18:30:38 +0900
Message-Id: <20200514093039.39558-1-changjoon.lee@lge.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChangJoon Lee <changjoon.lee@lge.com>

Hi, ALSA Teams,

This is documentation update purpose patch.
This patch does NOT alter any of operations.

This patch allows an application engineer to understand why they received negative return
such as -EIO, -EBADFD, -ENOSYS, -ESTRPIPE and etc which are not fully documented on documentation site.

This patch also exposes Expected Status of PCM based on bad_pcm_state() with P_STATE to help engineer to understand API behavior to the documentation site.

TODO :
We may need improve consistency of return value especially for snd_pcm_hw_params_current().
It returns -EBADFD when PCM is not setup while other API returns -EIO in this case.


 src/pcm/pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

-- 
2.26.2

