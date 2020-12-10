Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5962D6B75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgLJXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgLJXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:01:59 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A391C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:01:19 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so9736995eju.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnvnqJGFJGAEEl1+u8bL8r9N2i4Qe3s5dKeu7ZtnAEk=;
        b=Yu2/Z/tJHLbpJ4YbL85w4Xp8OKQyuSaX3pY0ZG+Vu5LAkciOCqvdAQP29O6/t1cVYE
         X9aw9fSISJgoci3z1WUNCrcUw4Bjvi7CQsbx2dVPKfQDu4YvgQavKzgUTgy1pci9Avv+
         VCeCTnq5qMjGEgQxhHI+r7LqkoUVEB+CODrqqdfnnbWwe0ASpTM8BXCguC09KI+uN6sh
         qroD7lWPMJAWWmAdv5Ch+BdMV8LBA5HZbzQOUQdvwG7VilbqmAiLtloSG+/4VAn5AY+p
         la0JSYQ7LD3j1Z+wHbndx9d/d3lMHKpSitwohcJR7lJb8sb+ff27vGwfuoNmHAnhjnOc
         E1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnvnqJGFJGAEEl1+u8bL8r9N2i4Qe3s5dKeu7ZtnAEk=;
        b=YcZo0K2QNkoH5mFlq96eaz8XaiZgm6ydZYXjEvDNcNfAqqiAvcis6zfJ9PuljeP641
         b/XtyW3xHEDl9b0Y9YX9GL0KpBVXsnASXwXKwQ00J3gNEve2IrVK/dV/n8fC0R1xJw86
         fnLck7T58Z7YY5P7Zo6kE+f6H9aOJdOgDIBISH+yQ0j2d4+q/YMNfX9fGcQlRPsAvtMV
         Y0roBKsW8Du2cegtU6871p+2VXAcipl5u4G79mFG1WYMezr4fZjB/MTLeDTK8euFIawc
         I623mvbNUVmS5cfaOoucJAVybQIgy7E10fl2UvlPSEYsIOlJUFllQhMhG0PvbryBbZnL
         lg9w==
X-Gm-Message-State: AOAM531A3Y5G0/R5F3btINFAJkTOIhxK7iw9s2I7Xk4igsYRmUPpZGPy
        OHlT/EThdCmjXrfXnhTAu3dOKDCf5r6D84lNqxdS9g==
X-Google-Smtp-Source: ABdhPJztbkFYF/AbPW9+Jw/6UkidwRn/IojK+0f4ljD0wVz/95d3jHjD6QlmWMZkdYAnF0oHFFAqMc9I9SlhCUMQE8w=
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr8250414ejd.180.1607641278306;
 Thu, 10 Dec 2020 15:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20201210041946.8961-1-chiu@endlessos.org> <20201210184930.GF26529@zn.tnic>
In-Reply-To: <20201210184930.GF26529@zn.tnic>
From:   Dan Nicholson <dbn@endlessos.org>
Date:   Thu, 10 Dec 2020 16:01:06 -0700
Message-ID: <CAJAOzpAC8V7iNnXDjdJS8Gu0pWsdZgy77ofcZftmfyOoOTDNeg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/reboot/quirks: Add GIGABYTE BRIX BXBT-2807 reboot quirk
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chris Chiu <chiu@endlessos.org>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Dan Nicholson <nicholson@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:49 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Dec 10, 2020 at 12:19:46PM +0800, Chris Chiu wrote:
> > From: Dan Nicholson <nicholson@endlessos.org>
> >
> > The GIGABYTE BRIX BXBT-2807 always hangs with the normal acpi
> > reboot.
>
> Is that what the "hard disk crash" in the comment below, refers to?

Hmm, when I wrote this patch several years back there wasn't any hang
when rebooting. According to our internal bug tracker, you could hear
the disk head crashing on reboot. The workaround was to do a BIOS
reboot rather than an ACPI reboot. My original commit message was:

    x86/reboot: Use bios reboot for GIGABYTE BRIX BXBT-2807

    Using ACPI, the hard disk crashes on reboot. This seems to be avoided
    when using the BIOS to reboot.

I don't know if this became a hang with more recent kernels as
described in this commit message. Chris?

--
Dan
