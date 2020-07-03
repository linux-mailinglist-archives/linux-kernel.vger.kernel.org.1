Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54F32140DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGCVbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgGCVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:31:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05269C061794;
        Fri,  3 Jul 2020 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3rUy7W6J3A1nt55ZYo4Uy0+DrIitznYqvXbwzlIymh8=; b=LKkoB+z5fvtJRfzMTQDWGDgdxe
        pbzJn2Y64uY3gPNJ/FOca40kY+gyJE+i+cEDvpUKLW1CUSQmUFM5QAU9E7IVKNpv+7xgV5fZMXFQ8
        9ZJb8aMtITeMeZmIXOYMOVLsHervk9uKiMXUpL+iNjd2UT2+9gfcCO1j0E2jVtvlmw7nfLR8v0ANG
        p2su+FA1+EoCELpm0ywyvI/Drk3EFXNbWvPmJ/i9BFOl/n+K3hgrjQx4y5s+fMBJK4/iewvp/jFWE
        cqTW6q1rFbpA901pJgSQZFVSN0NGvyr9ZvuoMqSnBc+gZ76deBmh/XubhoVxp2hTb6lAXp0y0lLCh
        J63ODJkA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTH6-0006Rx-RX; Fri, 03 Jul 2020 21:31:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] Documentation: x86: eliminate duplicated words
Date:   Fri,  3 Jul 2020 14:31:05 -0700
Message-Id: <20200703213107.30758-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Drop doubled words in Documentation/x86/.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>


 Documentation/x86/earlyprintk.rst         |    2 +-
 Documentation/x86/x86_64/machinecheck.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
