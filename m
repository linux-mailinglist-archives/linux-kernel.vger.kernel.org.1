Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29F22CCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGXR4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGXR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:56:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC3C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:56:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so4909821plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LPBr9y0mSQ0vEFDVd2yPcrY3mpjPcnCTz8oQxhRntWI=;
        b=eZoWliuezeOxys0b9UQOnD/o0lGyFr5fKeejVdFUARBWrlFx+qV4PZjxeb6W0f1v0q
         spduBP91FEopvvNX5ho4hKvodAgkrttgRK3rPTVXtOlImPSiICCvOps9A0ZVwkXhHHhW
         2aUmPdKVudVlnVPtPFeLyvUVR6CmhAVkjvfog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPBr9y0mSQ0vEFDVd2yPcrY3mpjPcnCTz8oQxhRntWI=;
        b=KU5chFuYLsyB7P4EbE59ctiNuLi8r+xvML/885snrCOMInEgLOKI0QBrw9cHQ4VOVO
         lpqVbEOExD/ZiuRa4UCElC6hrwYwVU7gn+d6No1D9uAKkB/5hN2y62O4mRQjthVV10sR
         gCYKbQAy4+V4SwCzaN1hN+jRZ9NZYxZXjdd3eEkkJ5IBGpQ7Ngq7eQJ4Acy/7YjC6XEo
         DuUTMRnLm9ZRhVlindqUmTyrgrrtSPaoCuB512lAfZC21xbm5T2AsVKJdCtVyc3TFlz6
         EIQpR+gOheLHn8VNa82sNEc8Ul1mxHIWdOWc4pzLYyD/XE5f9s14p+GW4+YaFFSr22aL
         CKVw==
X-Gm-Message-State: AOAM533EhNR5nKoYL0U5zfN6XJLZ+4O+ljoQI66/wQC6HCcuh8NM4COe
        7xB5gh4/v7Z52dAh9bPbSoNn7A==
X-Google-Smtp-Source: ABdhPJyDax/qJPR4ZLz3NJokDK6V9QQCwKq9zwdj3ZJ38OEFknglmOqbh2MmPwVgkyNP/voUnR7jUA==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr6997041pjc.117.1595613366344;
        Fri, 24 Jul 2020 10:56:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f207sm7271770pfa.107.2020.07.24.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:56:05 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:56:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 71/75] x86/head/64: Rename start_cpu0
Message-ID: <202007241056.091E681@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-72-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-72-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:03:32PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> For SEV-ES this entry point will be used for restarting APs after they
> have been offlined. Remove the '0' from the name to reflect that.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
