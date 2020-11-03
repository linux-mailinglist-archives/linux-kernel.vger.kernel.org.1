Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75B2A5AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgKCXtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKCXtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:49:41 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Nov 2020 15:49:41 PST
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7DC0613D1;
        Tue,  3 Nov 2020 15:49:41 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1604446886; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=i2qdVMDP9twJcSebiSavjnArNQvO7oLIxy00vTH9BjY=;
 b=Yu3zADwpKDq3VVmTYIqN5aabJJMfMCZQLRsFqBuCeoQV39DhjXImkQYAWnPW+VEjK858p
 hw7LdUCpWWXDtthDA==
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1604446886; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=i2qdVMDP9twJcSebiSavjnArNQvO7oLIxy00vTH9BjY=;
 b=B5tZezuSH77cScTfJajDEogNWRU463jha+J48CMuiBT8t5t4ZrMuEtFBHmN08cAM5MZhJ
 2j/uc7wunwf63unnXcBg4daVKkqMJBkhgTjjRhQbp50wHsqLa/dr6VnTniTRCFEcaMdwPwT
 jjD9oefE1SxZoX5FUwkn4rV6wEaEtQb24ZXr9XBeZUcvP2+YbsyBTgXMz5wMJjTzdoZ2kwk
 9MJnwOD8XvLmmjLVrY3TGGtznaHe+oXl8/7C4bAfl8d40T9X2w6szienZCYyiOukgiXJ2jr
 g7PWJP8V/lOhSywIPEX2ZHVIBVFt/Ucurup0tGcDG1irn23npqTdLLE6gBKg==
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id DD65360388;
        Wed,  4 Nov 2020 00:41:26 +0100 (CET)
Date:   Wed, 4 Nov 2020 00:41:26 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Andy Lutomirski <luto@kernel.org>,
        platform-driver-x86@vger.kernel.org
cc:     linux-kernel@vger.kernel.org
Subject: acpi PNP0C14:02: duplicate WMI GUID
 05901221-D566-11D1-B2F0-00A0C9062910
Message-ID: <88716562-a1c3-c8e2-655c-e41cff5f8aec@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while looking through boot messages I came across the following on a 
Lenovo T470 laptop with Linux 5.8:

  acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
  acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)

Searching the interwebs brought me to an old patch proposal:

 > https://lkml.org/lkml/2017/12/8/914
 > Fri, 8 Dec 2017 20:34:21 -0600
 > [PATCH 2/2] platform/x86: wmi: Allow creating WMI devices with the same GUID

The patch was proposed, but never made it into mainline. It's not really a 
big deal, booting continues and all devices appear to work, only these two 
messages get logged during boot. I'm just wondering if this needs to be 
fixed or if it's really just a cosmetic issue.

Full dmesg: https://pastebin.ubuntu.com/p/2pPv3hywPF/

Thanks,
Christian.
-- 
BOFH excuse #451:

astropneumatic oscillations in the water-cooling
