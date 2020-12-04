Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10AB2CF0C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgLDPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgLDPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:33:15 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] improve get_feat.pl output when all features are displayed
Date:   Fri,  4 Dec 2020 16:32:27 +0100
Message-Id: <cover.1607095090.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203153642.594afd85@lwn.net>
References: <20201203153642.594afd85@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

As requested, those patches improve the output of the script, when all features
are displayed.

The first patch was already posted as-is at v3.

Patch 2 is optional. IMO, it makes more sense for the admin guide to show
the architectures where the features are OK, then TODO, and finally the
ones that are incompatible with the features. I already sent it together
with a comment.

Patch 3 is new: it tries to reduce the width of the table, in order for it
to better fit on a terminal. With the patch, the number of columns were
reduced, in order to better fit at console output. Before the patch, the
output takes 281 lines with 158 columns (total size: 38.9 kB). 
After the patch, displaying all features require 439 lines and 92 columns
(total size: 37.6 kB).

While not implemented, it shold be trivial to allow controlling the
number of columns via command line (with a 2 line patch).

I ended dropping such control basically because I was too lazy
to add the helper for the two new command line parameters ;-)
(and because it probably doesn't matter much sense for the
user to control it  - I guess).

Mauro Carvalho Chehab (3):
  scripts: get_feat.pl: make complete table more coincise
  scripts: get_feat.pl: change the group by order
  scripts: get_feat.pl: reduce table width for all features output

 scripts/get_feat.pl | 160 ++++++++++++++++++++++++++++++++------------
 1 file changed, 119 insertions(+), 41 deletions(-)

-- 
2.28.0


