Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7671CEC61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 07:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgELFVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELFVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:21:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944DC061A0C;
        Mon, 11 May 2020 22:21:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y3so13701481wrt.1;
        Mon, 11 May 2020 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=iPNWrjCXLG5PobA8YJLbqbttbn3fSW2nFeC8Eks6Lm8=;
        b=bq2dqmF04qwpjjm8fxx3txA1QpoMZXU1/icZ9Lzk+Ur7CL/QanWEh+ELVDAHeu3hiU
         aMhdRWuN309gwOBzR9tmovi6pHfHZyb47UPAL7hqdl4ijuhud869SXUeNVgrQcRwRJlh
         XyAfUWl3qYgLFLZcHU68SQVsBL5iMS5Htdtt5/+haAkFr32uPyjUZZRVrD/obzXQuXx6
         Amob/waiJjU4E/KDCVNidVPbP0lEs93LCm7js3fUJc/p+a2Y6UynPRLnaqVwA8EI1aM6
         ih0yvIil0nIwTrl51Xl5zfbgK2Y+kErLZMtzZDaSjJJbnnto+oH2SyGlEJP8cvEvIj/k
         URaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=iPNWrjCXLG5PobA8YJLbqbttbn3fSW2nFeC8Eks6Lm8=;
        b=ejMEP6fHarbMzCeJU+fNmpq+WjdFKMPBwAZluTqlH7ccggMxdFOanPiS3epq2JhZ6h
         5wEu02UJsQwJ1+jM3c6NyNh3Ckc0BjCxm12xYUnKwdMKSqHd1GjM6HtO6sMcifT4TbTU
         OG+l5i2qe4BSwknpgRsaqQNmx1UdlMUgMWmWjvdRrcXO+U7hS+bZTj1bg7tSw/3Nd26c
         9npiD9M+3Nh6T69QSroN9RvbeoIerxuQ04qhH2Os86UG3+WoZ9vpoLaCEfB7ut7WttTI
         eHuI+SgwRMXrcs4Vc4rVmei1YgYZ0x/dCvTB16BR9CoCMlj9lGdbZlrQ3IWnAh0irUmB
         6XNQ==
X-Gm-Message-State: AGi0PubGdxJMVJWcwe0iiMKvt7g7a85s7i3YdZTUMXYCHd1lQepX7kV4
        rK/9x/il9SxP7YKMh5sqrEAS8G6AIBw=
X-Google-Smtp-Source: APiQypK7ThE8Zug7UHhcpytlSDewjztqnIvLlaa5ZIW10ubZlqdWzCXgNYxxjoFGF+Vxgm23GM0pPg==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr15531337wrj.387.1589260875606;
        Mon, 11 May 2020 22:21:15 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:4100:5571:bcd0:adce:c7ab])
        by smtp.gmail.com with ESMTPSA id 77sm21471812wrc.6.2020.05.11.22.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:21:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 12 May 2020 07:21:01 +0200 (CEST)
X-X-Sender: lukas@felia
To:     David Hildenbrand <david@redhat.com>
cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Wrong ordering in VIRTIO BALLOON
Message-ID: <alpine.DEB.2.21.2005120717260.3701@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

with your commit 6d6b93b9afd8 ("MAINTAINERS: Add myself as virtio-balloon 
co-maintainer"), visible on next-20200508, ./scripts/checkpatch.pl -f 
MAINTAINERS complains:

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
#17982: FILE: MAINTAINERS:17982:
+F:	include/uapi/linux/virtio_balloon.h
+F:	include/linux/balloon_compaction.h

This is due to wrong ordering of the entries in your submission. If you 
would like me to send you a patch fixing that, please just let me know.

It is a recent addition to checkpatch.pl to report ordering problems in 
MAINTAINERS, so you might have not seen that at submission time.


Best regards,

Lukas
