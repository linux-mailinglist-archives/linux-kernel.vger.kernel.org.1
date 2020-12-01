Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A603E2CAD85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgLAUjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgLAUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbKmbj2q3bXVVF2UGoGz1cN3aYCzV4bXk/zjzcW+Dng=;
        b=Ru1XjWW+/bQHOF2sZiJd+GgpbiS+m0xtya+X6xpHZJ3jFwD8bXUt+TOu7mLz2A96vu9hgz
        zfeqRj+sKhc+0EOUF379nxBVCW7aDznUSQK7ienXjo7JBvCa1R805dCpV7ReF4U5LYSeSz
        oJIO+uboL3wU82M4WG2umVz5VPL7FeM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-AGByv68qM9i8BTvvx-UTXw-1; Tue, 01 Dec 2020 15:37:47 -0500
X-MC-Unique: AGByv68qM9i8BTvvx-UTXw-1
Received: by mail-ed1-f71.google.com with SMTP id m8so2049645edq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sbKmbj2q3bXVVF2UGoGz1cN3aYCzV4bXk/zjzcW+Dng=;
        b=Gc0bFZbLZVf4y1ia/xuGPcfgKGIeDmFMIJFgvrX/AHe5NBxqIijlIOxZoSDG06thK3
         jb+7AiOVYH8h/LGiwixrkY/7wZ5OD9JwFWXDkkOXCSMG10UEYf5y07nJToyFql1vNjmQ
         VDIJYIfoFjeDjsXIFpcqXnG+MAxPEizbC+3dqT3UoJ/rMCCPvfibpMX4fYRtoRie7wOM
         FFp7kfGJFawPhblU2lPRg7/EZEVLbcWfzeOdw8SmWOzWlDh81c40QR2PS2I7UFGfjV+C
         0l0dho26i6e0aNYoDUClb190ltBcscXPmr6jAYVSobxevRiWv799+GWAK/DV/2C67hUt
         9FNw==
X-Gm-Message-State: AOAM533puJWE+9eAoJonZFxkNg8vfyB2BVJhKYIIgBefUbHWzusHPSOU
        l4YEcvcxcQ2/SdjfYOHl6ZtjFBRe/KIvjetdfRYzOdT/P8y5KdgaJIf3HD+HSbwvPAHOAtPSqWB
        M+e3XpSGFbwBjDMN+BmoX8KBo
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr4885647ejb.224.1606855066031;
        Tue, 01 Dec 2020 12:37:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6vxJmKHJ0YVxj6K63hN5ZVVl3SbRygXSOycPC+FEbzXuZ3rtlcfEyvNl8i5f5SUNgN2Hh0Q==
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr4885636ejb.224.1606855065895;
        Tue, 01 Dec 2020 12:37:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y14sm428849edi.16.2020.12.01.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:37:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 05B14182EF0; Tue,  1 Dec 2020 21:37:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>, asmadeus@codewreck.org
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: 9p: add generic splice_write file operation
In-Reply-To: <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
References: <20201201151658.GA13180@nautica>
 <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 21:37:44 +0100
Message-ID: <87blfd1cvb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> The default splice operations got removed recently, add it back to 9p
> with iter_file_splice_write like many other filesystems do.
>
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit =
ops")
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

FWIW:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

