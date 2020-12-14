Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C52D9643
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406856AbgLNKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406764AbgLNKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:24:13 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF413C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 02:23:32 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CvcsM4m9Cz8tqB;
        Mon, 14 Dec 2020 11:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607941367; bh=LyAUektCHqEIX02IeKSLGfL1PRMChPRbiSQV+a6a59g=;
        h=From:Subject:To:Cc:Date:From:To:CC:Subject;
        b=BMD1BDXMWqZ7ydHBqYtxQ9kZTCCXX2lvv8Yxu+mOxXMsbuQ9NqhbpWetMevKn++ut
         r0UCPJT2bomqnZMUQzeNb54Qoa71o3aheUyC38eItwOs6LiLZUjlDLrE0mJxuIBDn0
         fP0uxvIYqxo45YPj5hIWWuXO17oqXx2mapavHIAvaQ7FEnsac997uoAQT6i0Q5Hae6
         LphrdfnsCQue5jrm4qfn2r2pWv8/xyIV/BJLb85RJs3vZITD854e4kYeXc/ixiVkZw
         86aFMLea+crmQJM3AQjjpn0B+R7nA4Ccvtvewdap3c9V7fkDzUbQ0pjCWAKkZ36vXL
         KM6Lg2a3SZeKw==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+d/I2gcsXKP1ni89+WoAEXQCDGFwOsT6M=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CvcsK24JHz8sZT;
        Mon, 14 Dec 2020 11:22:45 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Subject: [PATCH 0/2] checkpatch: update kconfig parsing
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Message-ID: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
Date:   Mon, 14 Dec 2020 11:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the parsing of Kconfig files within checkpatch.pl
to the current state, as discussed previously.


Nicolai Fischer (2):
  checkpatch: kconfig: replace '---help---' with 'help'
  checkpatch: kconfig: add missing types to regex

 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0
