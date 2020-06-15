Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F401FA37F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 00:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgFOWYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 18:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFOWYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:24:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A741F2078E;
        Mon, 15 Jun 2020 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592259876;
        bh=KWh5J5k82sVWOKhsLlTlA3MMs+VaPo6HtzKgdAqj3gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fm332kqAcKPY58cxjfrBAa0U+cPm1d37yxXU4xy0yAiEAk6+Tis7TsOdmuDqIT9c6
         uP+Pw7JYBUSWMTIub2afbMrpW/JOyYcfCrur3haOyMIgfJsuulgJTeyPaLT0kQRi7I
         /8h5DCS+z9wkeb3SdmRelLjCOjrmWPnyPBwi3BpQ=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org, koct9i@gmail.com, jroedel@suse.de,
        luto@kernel.org, peterz@infradead.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] scripts/decode_stacktrace: warn when modpath is needed but is unset
Date:   Mon, 15 Jun 2020 18:24:27 -0400
Message-Id: <20200615222427.60126-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
References: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user tries to parse a symbol located inside a module he must have
modpath set. Otherwise, decode_stacktrace won't be able to parse the
symbol correctly.

Right now the failure is silent and easily missed by the user. What's
worse is that by the time the user realizes what happened (or someone on
LKML asks him to add the modpath and re-run), he might have already got
rid of the vmlinux/modules.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/decode_stacktrace.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 13e5fbafdf2f..2c9ee4beb545 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -27,7 +27,10 @@ parse_symbol() {
 	elif [[ "${modcache[$module]+isset}" == "isset" ]]; then
 		local objfile=${modcache[$module]}
 	else
-		[[ $modpath == "" ]] && return
+		if [[ $modpath == "" ]]; then
+			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
+			return
+		fi
 		local objfile=$(find "$modpath" -name "${module//_/[-_]}.ko*" -print -quit)
 		[[ $objfile == "" ]] && return
 		modcache[$module]=$objfile
-- 
2.25.1

