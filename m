Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677381D99E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgESOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:34:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156BC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:34:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so15363340qkh.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I+kJX+J2KIE+z0+rJrS5KOb33zv7opOw+7yLyrLRimM=;
        b=FEm90GcbKfF3IoLauskGKFUfBaZ1FRaSNW43V4AS9jRujhjSzFu6K8Dq3OxtKjmljA
         RDTmiK+BDKAoId/2Q/vnEZP1Zh5oYfDmJwqKPUBdfnCcKTg/54kfc1rD2WHMENYf80X4
         cbwDdhVwkZNfMlKYbTpFCfPzUAphSgTZ45/DfgoWH8foFfJb67Ll1/0P7Ev6fcky5T6n
         YVNvtbEbyuBzJhubGbLrIV2QkDsaQejLzjlrC+rBbsx0FSlk8KKtM9lyIW40/dAx5VwO
         kJ5UeRe2JRaRVvhNnNkR6yKUdPQxY8PX7uShWveZevmr9ot+DxC1YkrXRNCFWiheDRWK
         OGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=I+kJX+J2KIE+z0+rJrS5KOb33zv7opOw+7yLyrLRimM=;
        b=QNq7lzQh+P1QQ2t2D2mSUOF72rCkpaCOPBWWNQyxOXjJbUPc91Thk8RaDM4AVCViIg
         88qXqNnLe02I071R3H8ytfSnKWkLTTvNNS6IgNuue8L1JNByEAyXNV7vtBFu5Lr62iHJ
         eZZz75rRqesjT8XWPu6qiB0RS194XX0mPD1KujkB5+CbxuctFnGVcfxf0hL5RGXRwvBM
         O9fnR65MCxhfp/PFS0czg1MsWZ6nlFZ8r5E5vlBk9lQ64cfo7rNeDWZqDmsT1Dddes+k
         gp9YA2tP3dEZmn4uSTEB7EMrqU2IMd/rAFo7fdGsgw/3oPgzQrL4S5RsU6w7GK+O7IAH
         BZvg==
X-Gm-Message-State: AOAM532xi30eRICLtUBIdtz/HPfFzuJisZ0zB+lGMRn75sh7KAl+ClUT
        5vczg2vku++/yk9fPOFRU3Q=
X-Google-Smtp-Source: ABdhPJxxFn6BB1SiifYWj4BJy+msU+A+V7A/iVQ3Ht5Q6o5GRkyAUk96AkTAzQxofomCHC/eXSV+Fg==
X-Received: by 2002:a37:6547:: with SMTP id z68mr21232681qkb.197.1589898870869;
        Tue, 19 May 2020 07:34:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u56sm12601467qtb.91.2020.05.19.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:34:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 19 May 2020 10:34:28 -0400
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>,
        'Masami Hiramatsu' <mhiramat@kernel.org>,
        "'Steven Rostedt (VMware'" <rostedt@goodmis.org>,
        'Kees Cook' <keescook@chromium.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Dominik Brodowski' <linux@dominikbrodowski.net>,
        'Arvind Sankar' <nivedita@alum.mit.edu>,
        'Mike Rapoport' <rppt@linux.ibm.com>,
        'Alexander Potapenko' <glider@google.com>,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] init/main.c: Print all command line when boot
Message-ID: <20200519143428.GA1526900@rani.riverdale.lan>
References: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
 <20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org>
 <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:09:34PM -0700, Joe Perches wrote:
> On Mon, 2020-05-18 at 20:44 -0700, Andrew Morton wrote:
> > On Tue, 19 May 2020 11:29:46 +0800 王程刚 <wangchenggang@vivo.com> wrote:
> > 
> > > Function pr_notice print max length maybe less than the command line length,
> > > need more times to print all.
> > > For example, arm64 has 2048 bytes command line length, but printk maximum
> > > length is only 1024 bytes.
> > 
> > I can see why that might be a problem!
> > 
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -825,6 +825,16 @@ void __init __weak arch_call_rest_init(void)
> > >  	rest_init();
> > >  }
> > >  
> > > +static void __init print_cmdline(void)
> > > +{
> > > +	const char *prefix = "Kernel command line: ";
> > 
> > const char prefix[] = "...";
> > 
> > might generate slightly more efficient code.
> > 
> > > +	int len = -strlen(prefix);
> > 
> > hm, tricky.  What the heck does printk() actually return to the caller?
> > Seems that we forgot to document this, and there are so many different
> > paths which a printk call can take internally that I'm not confident
> > that they all got it right!
> 
> There is no use of the return value of any pr_<level> or
> dev_<level> or netdev_<level) in the kernel.
> 
> All the pr_<level> mechanisms (as functions) should return void.
> https://lore.kernel.org/lkml/1466739971-30399-1-git-send-email-joe@perches.com/
> 
> > > +	len += pr_notice("%s%s\n", prefix, boot_command_line);
> > > +	while (boot_command_line[len])
> > > +		len += pr_notice("%s\n", &boot_command_line[len]);
> > > +}
> 
> More likely it'd be better to use a strlen(boot_command_line)
> and perhaps do something like print multiple lines with args
> using strchr(, ' ') at some largish value, say 132 or 256 chars
> maximum per line.
> 
> 
> 

Should it use pr_cont to print the subsequent lines?
