Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E941C2D76F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394352AbgLKNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390535AbgLKNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607694630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gM69V9onbZaSEKvDodMrLsWMXGl6YnsxHFzlmXcxA9Y=;
        b=BOUz6eYFebWwm3dxwUlW9piR8Q3OOd0OZbgZLqM2y5HE1r5h50Hi7O5LeafjjfLuQr3HfF
        Wnv5jb+A1Do9Xt/yEBpkGHiHWMlx3KE1ouSgbRf75kMI2PAykwhZdt37wO+FDVaquo9iJy
        tB256ic8+kijnG9xgj52U+ZN8YCW/Mw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-BOMVnZ8XMbeFvnhz6OgDAg-1; Fri, 11 Dec 2020 08:50:28 -0500
X-MC-Unique: BOMVnZ8XMbeFvnhz6OgDAg-1
Received: by mail-qv1-f72.google.com with SMTP id j24so6465804qvg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gM69V9onbZaSEKvDodMrLsWMXGl6YnsxHFzlmXcxA9Y=;
        b=r5AFwgjyYvxf6C+faLjxUaKy9eEmoU5+rcJrXWoqw/3Im6Q85GgAhkckB15fTFqvUT
         HxhSoFLTsBzArHqOgdE8FdiQMamESaCii83PXWKn4mQ5ADMoYt4frmJ91bCVsQrr4ud/
         X4NYYTZLdOBusY+cASqJS3DVyOnltfRYlQeoJbgYEfdyvl5GOAnMLAAktvGK5HgBdCEX
         cwYS1pf7Rsh4U5vHO6rCtmvwDWD29TPQJ2eDnWBkIbiOTyQZCFbfbIRllCKv6Gzsug2/
         e68zs5T6+z9hiyFi18n9dWV54WOTPBQZ0VGtie2DscNHCGV7U8LOsRb/oy6ouEMgKMF3
         VRMw==
X-Gm-Message-State: AOAM530Ht8IIxzkYYQp9iJNq5B4xw+QpJPwK3LNDEvD0Mr0+vn5wjS6H
        i+KJj+Re3ANnC9nGeutoHLcIBzlaopYJbuf4w5lDtRtEf/l931BijW+NPG8uw4JAt3WsY6Yi7NQ
        PitXoFEt6101WtaT5M/ZzBUBG
X-Received: by 2002:a0c:ee87:: with SMTP id u7mr15458749qvr.21.1607694628097;
        Fri, 11 Dec 2020 05:50:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl8FSTDwklqSsBVOMAAYsYIzfEsbWjJ+ZJlgoVDvZa7GQsXoAv7CwhM/KGXYESSDZX/aBR6g==
X-Received: by 2002:a0c:ee87:: with SMTP id u7mr15458721qvr.21.1607694627847;
        Fri, 11 Dec 2020 05:50:27 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id u26sm7092520qke.57.2020.12.11.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:50:27 -0800 (PST)
Date:   Fri, 11 Dec 2020 08:50:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] x86/apic/vector: Fix ordering in vector assignment
Message-ID: <20201211135025.GA6520@xz-x1>
References: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:18:22PM +0100, Thomas Gleixner wrote:
> Prarit reported that depending on the affinity setting the
> 
>  ' irq $N: Affinity broken due to vector space exhaustion.'
> 
> message is showing up in dmesg, but the vector space on the CPUs in the
> affinity mask is definitely not exhausted.
> 
> Shung-Hsi provided traces and analysis which pinpoints the problem:
> 
> The ordering of trying to assign an interrupt vector in
> assign_irq_vector_any_locked() is simply wrong if the interrupt data has a
> valid node assigned. It does:
> 
>  1) Try the intersection of affinity mask and node mask
>  2) Try the node mask
>  3) Try the full affinity mask
>  4) Try the full online mask
> 
> Obviously #2 and #3 are in the wrong order as the requested affinity
> mask has to take precedence.
> 
> In the observed cases #1 failed because the affinity mask did not contain
> CPUs from node 0. That made it allocate a vector from node 0, thereby
> breaking affinity and emitting the misleading message.
> 
> Revert the order of #2 and #3 so the full affinity mask without the node
> intersection is tried before actually affinity is broken.
> 
> If no node is assigned then only the full affinity mask and if that fails
> the full online mask is tried.
> 
> Fixes: d6ffc6ac83b1 ("x86/vector: Respect affinity mask in irq descriptor")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Reported-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

