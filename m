Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD291B7D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgDXSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:01:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81999C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:01:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e9so11283888iok.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1oybE4UtsY48E1oQ+JXQwXzrfFrfANiZUHOgOeRFdfk=;
        b=zXmNZI0RhF7dF0NTK8G5HNlv0404xgwYGNIY5mXaHBm/uKjEtz0sWjLHF1zBW66EFG
         VGHd309EDujjzuQeAIIIdxcjkGWJVEljsrIll7MQ1QvwAwo/7OeU1BG/UsT+hkBa7Elw
         qXr6NAZ9E33GSXKhCxWbmmF1uM1n2zuM84cR7ATH6wgeilE7uXpKjUQmj8tAGpXbgpUk
         DPxkVup+PY4HnOLs/UC6/JILfhS5FJIqpTZ4159IxCH9V4t+J0HGf51jUOynvHnltQGx
         aBD8aOmrUD/nfF5z0MmOlqumAguPiDBMYS0mNjSWuXswSHh6SnTRgDxnqxsRKTSg0rVI
         hExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1oybE4UtsY48E1oQ+JXQwXzrfFrfANiZUHOgOeRFdfk=;
        b=AlOqgqSd3VEqWU1lvVwzyqsO19WnEtOhe8CwKcfjtsvEIFzwVuz92eMvNc9rExEyKf
         kyH64bE+Txx9s+/8QAZ/BMZuR3NrxcXDg70BPuF20Ob2Ag0s6AaLaaXOuvlFx7Yp9zGj
         n/RbjJVZMMZmJ1242fETgIJ0ibrCC/ul/TRtumS7QQxuQplYW1RATpkter39hkbudp8i
         z5Jz8dXGpNNAlY+Nv6iICRljRc4DYWnO5of+ayuy/Vhn6gZgZLeW9NkadBY0d3XXoOVQ
         oPZScxm4cCnxtiiuN6TXV9zO8jyMEZBW+u83Qjr07MGPRRv50tOzuUvHexp0Hqb/DJSO
         HEgA==
X-Gm-Message-State: AGi0PuZcuXC2Uwl9PgNiEqI9AFWrKvJxIkJfH2bSBq8rv4ypjGj2Kznf
        nBBztZQf3yCkVc1WL9M99oeDzvTuUSngJA==
X-Google-Smtp-Source: APiQypJACSWzxwOk8iJW0Gzgk3N2pnEr13CJ8ialCy5jJK+w7nqfsGeIP0nWZX+GwT+4TYpCMEQrnQ==
X-Received: by 2002:a02:6a4e:: with SMTP id m14mr9598661jaf.17.1587751309737;
        Fri, 24 Apr 2020 11:01:49 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k18sm2019958ios.18.2020.04.24.11.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:01:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.7-rc3
Message-ID: <0c2ac794-edf3-671a-7e6b-3b497e7c36ec@kernel.dk>
Date:   Fri, 24 Apr 2020 12:01:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Minor spelling error fix for libata. Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-24


----------------------------------------------------------------
John Oldman (1):
      ata: sata_inic162x fix a spelling issue

 drivers/ata/sata_inic162x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

