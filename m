Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508FB2D3D16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgLIIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgLIIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:03:14 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:02:33 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w79so484765qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IEUxWx3vH19PNKRLL9OD5tybmFL6ZHe5G+gt5qni5Ao=;
        b=Yaq2pS+6XNTzbrO6ExU1tVZn1zo2WeU5FBZqD67Z7bbabNA0TPwy7wjhnwJfFWnTgz
         sL6z8fFh5om6EQZBUyQLOYK5cFumYhW7t8CjFWaQ6ye6OjksZRHOJENX0NOoX4vqmjK/
         feANVi7B3gqNlnDszfJGexUnPC9cDjT/3R+OnWxMiDW9WRZQ1SDALmuAq4fvXPrqE0/y
         PQH1UNGVCMaEoq+EI/klmn+SJ+l2lWMUMO/wIj5B+oa7lu73ogDB9Q8FGk5iojUI/duy
         yXamrKXyUxxQEogfVt3AEDDZMDaKIhEZXlSHCHeGFhxrAqjzrv2IB0N3Jq8/++afVAub
         Z5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IEUxWx3vH19PNKRLL9OD5tybmFL6ZHe5G+gt5qni5Ao=;
        b=b2QqjD4TNOEQvB13d/N24WHYDi8FVMNSFrWLsQYdMrxLlnlmXVPRHG8zqvQgtIWQwa
         Be/aLLAlvxNIemofEw7g974ErubjG5ifa83J8gldEn2nRPM/mflGU+/DhKaVsvw6Y9e/
         irQT10fZpV0z1AoRX3u2Ads0dDhlWeMgrne71agfDQht1inhOVk7j/ziodgf+oXfzOTK
         AWsmP++aUzW0rmhXRHcYchHtsgizRsaU0j10f8EkcV+TP3lqkjpFJqvIhFv1ijvKGdVD
         /9QD7vHQq0eD1xvJXAWY2iKa2GD2gJJQHCioeW8lKVrxfl3yaCJ8GpsVeVnlgB9jiI8M
         75WQ==
X-Gm-Message-State: AOAM530X9MYt+njWO6HEM1ywY44ZrS0KBGs8s1wtE8kpvRSPzv0H8wdK
        txc1c7wtOou3y2ed8RimV4GFDKuZWySFdUDIZEJZkA==
X-Google-Smtp-Source: ABdhPJyLsBobnxSyXlmo0/tiEf5nJQSCwjohgCExPpmZXOGaw2XVImtJCIO5cRJVK8PiPFhiYkv3tF17o8aiUDKe7BU=
X-Received: by 2002:a37:9a97:: with SMTP id c145mr1693956qke.350.1607500952712;
 Wed, 09 Dec 2020 00:02:32 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Dec 2020 09:02:21 +0100
Message-ID: <CACT4Y+YEo4G=WjC6T13PbuwZ=790TVdDFW5_CjX=zODnXw=ULQ@mail.gmail.com>
Subject: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This stopped happening a while ago, let's close this to get
notifications about new instances.
One of likely candidates:

#syz fix: net: partially revert dynamic lockdep key changes
