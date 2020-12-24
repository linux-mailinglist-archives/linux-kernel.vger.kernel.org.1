Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CA2E2591
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgLXIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgLXIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:55:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A85C061794
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 00:54:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i7so1201976pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 00:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=jtdNY2VNTaifNGfA8i/OocVgmbv/j5wlSKB4fx9rrOM=;
        b=fKB/48z1yPhzRupLluTznUgCXkB5yDE+/f+UvQOpul0kmVgQaR5sNCj6Tjjju5+rYU
         at35S9Gka9w84YU2qEO3o0uwZgBawp0uT6gaoXEy1EIhY7AVrHqglai1JYqjzY5B3oBW
         hHkMG+vAa+5du/yo+229OK+cgzHgp+ydTzz3TfPjHWCfhWn8Tug95pNPLF8zdobI2vq5
         ZwWx2d50HkoFxgXJqJZrrghsIBUeFqncYsuhpWpIazLkbSsSc18VTXtagpf4pxJJgaNP
         iifJ5yexwfZwNEtj8M8d0kYlHQFOG0MgytnHsXH+/OPM0pkn+8lN63cJYpusn41Z1fzu
         cMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=jtdNY2VNTaifNGfA8i/OocVgmbv/j5wlSKB4fx9rrOM=;
        b=nkIg9QsErjDQaj+8QWHQz0m4l8m2iCGBcKiPrtng+1Uim/cGGSuAAkUEn22L4xAtb8
         0HN3pw2KXWjAGGZfCz0CFh2wlunEPwEWksqrlsNXTa0NEmAhAv0VkolqyTjmNZmxBC2m
         UjwWQ2WsMBsrYu7vRs7S6jT5gJAxFLeH/EOQILk4yU4/2EZCF5/1P7uq0bvVxJF7qB8W
         mmTRWRxJQhbbIAhYI7bgtJGz4rqs5fyt8EUFrSfOvAipCIfzV6qf4ia4BzXXC721+592
         ViQx+syWgXx/chOwr7An6GdLM0mEph6xCkZjcX+lZGpxKTwbiXgc/lroKxN/yWipBwMo
         YE4w==
X-Gm-Message-State: AOAM533l+JTqCr1if5HQLN2eguYWH5Hls/HLaZD+f2keCVv9f5louaHm
        W4wevSuXm/SmrKZZ6c64zFqcwSHuoZuKtfZV
X-Google-Smtp-Source: ABdhPJwYg+NJY8USaLGRxba2CeUWevYKYMFVZ2yfeE/1TO2ws7jpZKfj5waR9ixjRaQoQCWg0we8xA==
X-Received: by 2002:a63:1322:: with SMTP id i34mr27986669pgl.282.1608800071053;
        Thu, 24 Dec 2020 00:54:31 -0800 (PST)
Received: from HQ-MacBookPro.local ([103.88.46.201])
        by smtp.gmail.com with ESMTPSA id w9sm25213503pfj.128.2020.12.24.00.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 00:54:30 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Bruce <rookie.bruce@gmail.com>
Subject: How do I account for the Linux kernel development team
Message-ID: <6f9e5b6a-9936-3619-d288-c88195158468@gmail.com>
Date:   Thu, 24 Dec 2020 16:54:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How do I account for the Linux kernel development team£¿

