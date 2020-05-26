Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B051C2CC1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgECN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 09:29:24 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:59310 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgECN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:29:24 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 2F14618CB; Sun,  3 May 2020 15:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 2F14618CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588512561;
        bh=sFGicPa3iLNjtjg478e1D/ADKIbqHmDGGrFqDiMuM28=;
        h=From:To:Cc:Subject:Date:From;
        b=J5YZ98QNwPOE7zMGAJcdy0+zJ+4wM6lDHfap69Pv1uE9FX9ZYPKebsXY9AQykWEPx
         +TcX4PicRyyxpAw+3ADw/MXgeXtuD1qgzvWRHIvR22EZ+AzNM6sp3KTcBnPjzmgAG5
         E8OSxswCPgpKi9w4I3csq09kV6Iz9rS9mUwc9c9s=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 0/5] Cleaning s_uGetDataDuration function
Date:   Sun,  3 May 2020 15:29:07 +0200
Message-Id: <1588512552-12297-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will eliminate few checkpatch LONG_LINE errors.
Simplify code paths by:
  - returning at the end of case body
  - removing unnecessary else branches

Matej Dujava (5):
  staging: vt6655: merge two switch cases in s_uGetDataDuration
  staging: vt6655: do calculation of uAckTime first
  staging: vt6655: remove else after return and invert condition
  staging: vt6655: return at the ond of case body
  staging: vt6655: extract index manupulation out of function call

 drivers/staging/vt6655/rxtx.c | 140 ++++++++++++----------------------
 1 file changed, 48 insertions(+), 92 deletions(-)

--
2.26.2

