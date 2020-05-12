Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29961CF1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgELJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 05:36:42 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:37614 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725889AbgELJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:36:42 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2020 05:36:42 EDT
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 12 May 2020 18:06:39 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: changjoon.lee@lge.com
Received: from unknown (HELO MacBookPro.local.net) (10.157.161.30)
        by 156.147.1.125 with ESMTP; 12 May 2020 18:06:39 +0900
X-Original-SENDERIP: 10.157.161.30
X-Original-MAILFROM: changjoon.lee@lge.com
From:   changjoon.lee@lge.com
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, ChangJoon Lee <changjoon.lee@lge.com>
Subject: [PATCH 0/1] Documentation update
Date:   Tue, 12 May 2020 18:05:46 +0900
Message-Id: <20200512090547.76991-1-changjoon.lee@lge.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChangJoon Lee <changjoon.lee@lge.com>

ChangJoon Lee (1):
  Updated negative return values for documentation update.

 src/pcm/pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

-- 
2.26.2

