Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54912D9649
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406789AbgLNKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395123AbgLNKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:25:08 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 02:24:28 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CvctQ0ZRKzPkXn;
        Mon, 14 Dec 2020 11:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607941422; bh=uUM/qQe7xT2ekBpQBS9f28sj4Pxras1gl0Ejr5s/mIQ=;
        h=From:Subject:To:Cc:Date:From:To:CC:Subject;
        b=fY9C90NH0iuyZzWbxtGrBYjyMyKba9TPMva3Jpcr/Ix4w4IBEsLhP2UyP/Nr6NynK
         2FfdiFZLQImmI7IK4Q4qdkrZTmAm3wYvabYRNkqJQm4zsSJuccDhZwnVBTeAsIHQNo
         ZeDVPOekA3fWC7rttlCWgUiNtv2ES2gW+TSOJ6jBt86Bbif6liB1AOQMyFi0UEHnFP
         HHp7qTSI0x7VMQctOSCQj+KSRU5GuLmbOvTLsg/XRCHVJblBxluR+uDjBX/T8v+d7S
         PXFJDNyb+vmCYu77W4DUnCQjXlKYns5Yy79+V8dNzaMLcpo+aA+gQPkCcjCO4CDWwm
         cl6tx5ueYukHg==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+J0BqfYrzIjxKdPov3fb7P8JsKItkbfKw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CvctM5nBdzPkxH;
        Mon, 14 Dec 2020 11:23:39 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Subject: [PATCH 1/2] checkpatch: kconfig: replace '---help---' with 'help'
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Message-ID: <eed0902b-2c5d-61fc-bb88-7edf286832c7@fau.de>
Date:   Mon, 14 Dec 2020 11:23:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All '---help---' lines have been replaced by just 'help'.
Therefore it is no longer necessary to include '---' in the regex.

Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 52f467fd32f9..5cd98f2b75f6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3323,7 +3323,7 @@ sub process {
 
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
+				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
 					$length = -1;
 				}
 
-- 
2.28.0
