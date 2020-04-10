Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DA1A49EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJSfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 14:35:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36854 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iE3hzL/9X7rG7H3ZLH0Kx2JNDMI6UfSi0bHUIshctfk=; b=TKMLGyc44N6rFRxM8pK0FRxg9
        E1N11nA7yKnQnQV9Wx7lJKK8uMbQ+ZzClB0zVKA2GUJuF4BE8VkPUs3DX6xPLwmchc/MFkFTAZo79
        74Il9X8AheqK1S41djmmvwLmVLy8IV3E3euxtC6YfSVwIEXNIJMfWwAMWCZS187WgJH2vh2BVKPPq
        5RJJ8reztG64yD59k5vz5+emm3sys/r+t7dr0SKNULKkUvpBICIBwoj3He4JQvjk4sD1BEM40SSBX
        zkwqtkTYb4ekXAunYE5bN+kaolyIuPXAmsT4msjInHEqXw14VQtlnhQbrHU2xlVAgRkaIXVWn3B/S
        7iJ0qG+Iw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48304)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jMyU0-0002yv-1a; Fri, 10 Apr 2020 19:34:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jMyTs-0004Fo-Dw; Fri, 10 Apr 2020 19:34:20 +0100
Date:   Fri, 10 Apr 2020 19:34:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, Peter.Smith@arm.com,
        stefan@agner.ch, David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        manojgupta@google.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux@googlegroups.com, ilie.halip@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        samitolvanen@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        jiancai@google.com, Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200410183420.GE25745@shell.armlinux.org.uk>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <20200410165948.GD448831@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410165948.GD448831@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 06:59:48PM +0200, Andrew Lunn wrote:
> On Thu, Apr 09, 2020 at 04:27:26PM -0700, Jian Cai wrote:
> > iwmmxt.S contains XScale instructions
> 
> Dumb question....
> 
> Are these Xscale instructions? My understanding is that they are an
> instruction set of their own, implementing something similar to IA-32
> MMX. 
> 
> Would it be more accurate to say CLANG does not support the iwmmxt
> instruction set?

Yes, because the XScale core on its own (otherwise known as 80200)
doesn't support iWMMXT.

It's worth pointing out that the iWMMXT instruction set uses the
co-processor #1 instruction space as defined by the ARMv5 ARM ARM,
which is also the FPA (floating point accelerator) instruction
space - which is the FP instruction set prior to VFP.

The LDFP and similar instructions that binutils decodes the opcodes
as are FPA instructions, and the LDC2 instructions are their "generic
co-processor" versions where there's no FPA instruction that matches
the op-code.

I'll also point out that the reason the iWMMXT code has never been
ported to Thumb2 is because there are no equivalents for the
co-processor instructions in the Thumb2 instruction set defined in
ARMv5.  Hence why the file has a .arm.  So, the fact the file hasn't
changed for a long time and hasn't been updated with "improvements"
such as Thumb2 kernels is because that's completely irrelevent to
the ISA.

It is an example of code that has become stable and mature, and
requires no maintanence with GNU toolchains.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
