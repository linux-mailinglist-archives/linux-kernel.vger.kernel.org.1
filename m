Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22A52140C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGCVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:25:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9DC061794;
        Fri,  3 Jul 2020 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=q4J879L4YQKukzKjdiMRKCK48D9NTUnc6yNfM2nMmEE=; b=NjwFR5rATHmGpubQHBZiHM3tSB
        5SxAmYnqfIgEcs2T4xD+epYC9StkjmQW1ltxYfAJUMM595lp+qq+QTNvwKaMhHJJri2apmRID521L
        oPnPNfkfV/uQPHeVJ80YTSoiqPl1vXvKTjMkcgeoEZhLszEt6QOz3wzvRQB4nCgKMVnQhM+QJtWap
        YhTUee7zUvxYPme8pOhYhWv1F1kJazmrDqqqPJDYZ/+Llm3Ij+OnOkSeppDri3121F4QbDv6Ue/4f
        zuXqCH3MbtUlkMTY0rO7N+Wl778r60TkruQgxESvSZXf1We3YtvxpGYZimj2Js7PSAqWR6mmCu+wd
        JUL5U4bA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTB3-0006Bh-OS; Fri, 03 Jul 2020 21:24:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/3] Documentation: trace: eliminate doubled words
Date:   Fri,  3 Jul 2020 14:24:50 -0700
Message-Id: <20200703212453.30553-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix doubled (duplicated) words in trace documentation.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>


 Documentation/trace/ftrace.rst           |    4 ++--
 Documentation/trace/histogram-design.rst |    4 ++--
 Documentation/trace/stm.rst              |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
