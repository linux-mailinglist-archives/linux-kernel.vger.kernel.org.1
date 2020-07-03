Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8AF2140E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGCVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:33:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D81C061794;
        Fri,  3 Jul 2020 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vOGqrnW744UKt2k+wSHRufoFzD8n+k5o7+pIfnL3bUg=; b=VLvUnj2LkH29bha04e2c+nizH9
        WlzZt2UA6SI387b10X9b+8BR5SUrYVsAOF01yM8A7mpvCe2eHwN0IZyyAhz2jXFrpLr1dW/eCxGy2
        cQdVRmsliPLYbNwQe4i2nBdotEIugr5DJYQWL0HbqtAFqjY1hMi7sMZg9Uadkw80dEy0gv32POkel
        uZahkt/qbh14mb02EJurg3nlUWk3uJ4WM3l0/ADh0pfcAXXh4AYse5+jr8T6Jatg0sz9h5Y6z97EO
        1w6slbSkC0bqOWTSvV49NcK9WcjR9VftUnYg0yIBT6upvwz3b2u049a3VTQlrP4dPJ0ICqOYGSCo2
        KCt1fYUA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTJc-0006YP-W3; Fri, 03 Jul 2020 21:33:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 0/2] Documentation: RCU: eliminate duplicated words
Date:   Fri,  3 Jul 2020 14:33:40 -0700
Message-Id: <20200703213342.30842-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all doubled words from RCU documentation.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org



 Documentation/RCU/Design/Data-Structures/Data-Structures.rst |    2 +-
 Documentation/RCU/Design/Requirements/Requirements.rst       |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
