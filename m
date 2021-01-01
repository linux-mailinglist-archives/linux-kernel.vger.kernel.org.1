Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CD2E85B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbhAAVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbhAAVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:22:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBBC061573
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jan 2021 13:22:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o19so50717482lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/t+YUq5T+ELO4aOtS9plxw75Wi8Om3hyqh2Adc8MEI=;
        b=dKKZr5xFIrSTAlTu+ix1NH8DxFEU3G8oH6e6h8Sitlp3uawgNXOut539JreZMt5j1T
         9v/qLcylBLWlZEZSZSSzuQwezNhlXB7kzDwZLp5QX32/w8Tm3CXxTDDqu1T7Yulux+Yq
         RitFzhBm4N3B8EEuTDExRa5WHblQEeQ5Ktk0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/t+YUq5T+ELO4aOtS9plxw75Wi8Om3hyqh2Adc8MEI=;
        b=FAz0UhLWcd4qJ4Pd5QubS4edLJEcSiOJVuWO21SO/fvb3vV1snP/JogcMS2JGcz5Z3
         iR6PRWSDaZN/i+PsTTdKIhhyPSw5UOiOtz8wub/uaLJLqVse1jOJG0QjZja/NZ2kdTOo
         I7KcS1rIgCBe/5w3qbkLq8+l81j6ZWxZaniJ7Q+KHJkWfWMsQqbchXxmBl8N04Q/opX8
         OqOju5UF8iCv8px+GIrkV6V+SMWkzM3BoYPk4xo0K2wRtJvbUIB+tXu55/w5TJhtveOt
         znnIuZxASIQm2fCXttF4dpAJ523C3KbQ9G9/hJHwL0TttsXx9wrgL7uwHkXw3roMLQsy
         +KbQ==
X-Gm-Message-State: AOAM532sL28WMcBda8HV66Q164Num8XizRaNvxiqjJGlB536ulp7tB1Q
        z4tcZZz5Taj8378/UEwF3epmUVk3N9XHEw==
X-Google-Smtp-Source: ABdhPJyZEUyCS+jzwreN5icJ0WjVWGQW3v86safUYAV9V0QWL9Ti7a404vhnUoWeUehlqxLYqzQGfw==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr32460390ljj.448.1609536129946;
        Fri, 01 Jan 2021 13:22:09 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l6sm7997168ljc.11.2021.01.01.13.22.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 13:22:09 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id y19so50471791lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 13:22:08 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr25712082lfd.201.1609536128658;
 Fri, 01 Jan 2021 13:22:08 -0800 (PST)
MIME-Version: 1.0
References: <dd63a06d53c45f9511307085797086351784b1a3.camel@HansenPartnership.com>
In-Reply-To: <dd63a06d53c45f9511307085797086351784b1a3.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Jan 2021 13:21:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=widrXOWKSaDmMLZyhJzUvKx6M0uDP1xGJzYB4YGAJqHJA@mail.gmail.com>
Message-ID: <CAHk-=widrXOWKSaDmMLZyhJzUvKx6M0uDP1xGJzYB4YGAJqHJA@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 5.11-rc1
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 1, 2021 at 12:19 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Originally this change was slated for the merge window but a late
> arriving build problem with CONFIG_PM=n derailed that.

So I've pulled this, but we need to have a policy for reverting this
quickly if it turns out to cause problems.

I'm not worried about any remaining build issues - but I'm simply
worried about some missed case where code depended on the block layer
passing commands through even while suspended.

The block bits would seem affect non-SCSI stuff too, how extensively
have any random odd special case been tested?

So I'm not so much with you on the "the scary case is the spi domain
validation case".  I'm more about "what about all the other random
cases for random special drivers"

                Linus
