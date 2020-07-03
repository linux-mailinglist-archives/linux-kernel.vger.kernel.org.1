Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466252140F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGCVg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:36:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B527C061794;
        Fri,  3 Jul 2020 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=l5yjvTEpP+YsS16qaB8R2z6IbIaXW0kYk4dGPKzsvto=; b=u3ZH7sLGSwZN9kueVIOaqjvXe1
        vINkND6Jj+Ih61frfJ0i+mEjBpjJqwDCBPRbpYFoIV9/qnRWLbjx5hYUzAnutRGKYp1YZMVbupwVX
        Log1rcx8P+cLwzyj+5Whf//RDRo8+oiZF+xUvzvVMWe1RJRUl4Y5W70b3exGWAAscaM5G0HHegYnb
        FyK4WOU1owFyHc7t6uqyAoC5qZZTbUvaGzOj1ZGOrsBl+wRUDWP4V2DT256VVirLeYFgCX99ca4c5
        VIKfztjbRLg3ESh9Igkl3GkMKjtEvtGhgCe2lQaUKsHSsB8VW0Pa8NXPLHoI/bcbUFJty5Qtq6UED
        cXrfQxtA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTMc-0006gs-RH; Fri, 03 Jul 2020 21:36:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] Documentation: locking: eliminate duplicated words
Date:   Fri,  3 Jul 2020 14:36:47 -0700
Message-Id: <20200703213649.30948-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words in Documentation/locking/.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>

 Documentation/locking/mutex-design.rst    |    2 +-
 Documentation/locking/ww-mutex-design.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
