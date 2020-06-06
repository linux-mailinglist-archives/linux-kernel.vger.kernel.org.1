Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C451F05DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgFFI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFFI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 04:58:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A7C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 01:58:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so6328148pgn.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4GQMb8Nb0ppLYW2rE9M0rp7cTPLVnp9iUypsRvJ/Hds=;
        b=jpBr/WGQjriKnX/rNrN6/3ksuCr+B8P+zJ0oF9HUMIXPffbDYMNQdsZtXr22IiOw6l
         BDPBCxWaqCLsmO/Ptb2Ppxaq82RlJtRgRo18hZ7X1BwS5tLIqEawAgWlBd6g9oqnmUDK
         pgMa8jrufS/icSCEgbYxL822M/ddWT/GoS3Ld4gNqvYwrXsFOzn7+u8z3mvPOGod3Vjn
         JDwS+Wroeqe5EGfh2MR3IL08rw4hxkKOhSQzt0CSEk/6Bhj/nP0M4Qs+8dk0mB4D1qVO
         2aluF+6k1yh2w/ch3MjcqckA69X3b7CHTFSn6rHT022OkctiaB2kVAzUHQuPD0HF88GG
         A4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GQMb8Nb0ppLYW2rE9M0rp7cTPLVnp9iUypsRvJ/Hds=;
        b=DI4a6gXsbUG0YrtOW8u8duLqo0WZqwCB+wtSwj2DNxH8+S1ehmFQuGZDBXavMe4KEW
         5xRFTa5B6yOh/9N2j+E7nEwJYp6ohu7SqYzrKfOCFK46NzVESTYs8Car+p2b/W/gwugv
         zll4I9EzB40J1A/AQ/2rwSEl15jfGrKT2w/g4PSrV0ExXYnQe2PGzEOxBVPulqWrVpoq
         EnqY3jfD3zHc6lERh/04ZxsJWceLMmoUGL+fAmFJst5D9IIHJ67b2/AfkdClO+4zF/km
         U/IXbRXUcXkxY38gbb1XV0vwtsn9ODGDzjyM9VO1aKx4vPrZZVm/YABrmqsAloYQ97Ro
         uNqQ==
X-Gm-Message-State: AOAM530kQWsjTB/E/oTyruSDjZK9PpzyEMYYUO5+/MuPQ9F5NboFzvDK
        EnNBXGiRYvmgPPXEhuWxKI/otSJ+
X-Google-Smtp-Source: ABdhPJxIYXXnZ1MIaB4lBImX1CnGc3obC46IUhjsWTw/Sl04M2Cn7Ymq+/QSFK/KWCSm6vqkF7cWog==
X-Received: by 2002:a63:741c:: with SMTP id p28mr12856359pgc.33.1591433904823;
        Sat, 06 Jun 2020 01:58:24 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id 136sm1796354pfa.152.2020.06.06.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 01:58:23 -0700 (PDT)
Date:   Sat, 6 Jun 2020 01:58:22 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH RESEND v3 0/6] arm64: add the time namespace support
Message-ID: <20200606085822.GA8351@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
 <20200605104904.GE85498@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200605104904.GE85498@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:49:04AM +0100, Mark Rutland wrote:
> Hi Andrei,
> 
> As a heads up, in mainline the arm64 vdso code has been refactored since
> v5.7, and this series will need to be rebased atop. Given we're in the
> middle of the merge window, I would suggest waiting until rc1 before
> posting a rebased series.


Ok. I will resend this series after rc1. Thanks!
