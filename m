Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953AC29958C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790181AbgJZSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:41:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45528 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785156AbgJZSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:41:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id f37so8908313otf.12;
        Mon, 26 Oct 2020 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtAav4KOF6vlssuz6rzXi18ZkZ98PZSjPjA2zZ94/ac=;
        b=oSA/q0Uiq2dcNtDeDX06qa3oOmQvYeYXaERUdVsansz+MM0d7Drfg74/yqE0aSd8Y7
         JIgoMgMoMY4wskFOcJDpl/55hojdXPqCmdUePYKTQHSLtH/JbsTjvBAh3pOxP+PXmbJ5
         KPICygLxIaFXNYqgqiAuOB5kgSfAUI8/3RFqZPbp+Yfw/6QxmVjVO898rEShVOTgYMjF
         8rFewKbcGtwmHFaFWuDVZ7CJ3hUJudvFUia6/okRoS55QTB+pjUN2NryQqd/SpAYnJW3
         TxhZalqZm/nOEfLOr/q9Fjfo1MArCkPYXaDJeiAGV60XWa68yECbJU8iKMKFC+ofq9Vg
         kbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtAav4KOF6vlssuz6rzXi18ZkZ98PZSjPjA2zZ94/ac=;
        b=IE1b+D+R26h1iryum+bQJLnDs9KBc1d20tvkAyodRSEbfbJ1zYSr9UmEszHry+Q6JX
         Z74/O2sVc71PbhcS0fpE5fp1JsWXKm+FzQLJMAQY5OLiqBIvH1OlEYgAvJgM8Fmpb8Xy
         NUNsgjo5loJbZM61AM9RKT368Wpzq+zeBpuIet+oEitk1sH0vV+QrPHYqTOnLv2V8R0N
         fJx6H/TO7oE309QLjmwNPeqTYp4X3PsWpwszc/jPngwHTfv2ZF3vZd4WEA0xBceV7E+6
         YaMyziXuSNI/Nnal0OwnQ0+YNiw08bRCniBKfKHk0T830mby2xCFpGzfG6tMUI/m7uGU
         oMjQ==
X-Gm-Message-State: AOAM533kyUrX1jqcgIvQcKtV5SGD4uCVlzfW8bHUY/jM04gJt4qr6Ubj
        VtKkt5KpGIrj474ox/7+KX4=
X-Google-Smtp-Source: ABdhPJxfMbwvwYCoWmExxfWhw2UJTu2mlZgiUFKjSflgI4qGXchLHgDXr0l1mAfEF15q7xrRmCOlyQ==
X-Received: by 2002:a9d:72d6:: with SMTP id d22mr12260704otk.211.1603737714007;
        Mon, 26 Oct 2020 11:41:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13sm3880072otg.66.2020.10.26.11.41.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 11:41:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 11:41:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add Corsair PSU HID controller driver
Message-ID: <20201026184151.GA60513@roeck-us.net>
References: <20201026152515.GA55313@roeck-us.net>
 <20201026183504.777cd579@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026183504.777cd579@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:35:04PM +0100, Wilken Gottwalt wrote:
> On Mon, 26 Oct 2020 08:25:15 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > Changes in v2:
> > > 	- changed comments to hwmon style comments
> > 
> > This is not "hwmon style". Please read and follow
> > Documentation/process/coding-style.rst.
> >
> > > +	/* at the start of the reply is an echo of the send command/length in the same order
> > > it	*/
> > > +	/* was send, not every command is supported on every device class, if a command is
> > > not	*/
> > > +	/* supported, the length value in the reply is okay, but the command value is set to
> > > 0	*/
> > 
> > Please read and follow Documentation/process/coding-style.rst
> > for multi-line comments.
> 
> Sorry for being a bit slow here. I did read this but I also used other
> drivers as a reference, which I shouldn't have done. The next time it
> will be correct.
> 
> > > +		*val = corsairpsu_linear11_to_int(*val) * 1000;
> > 
> > Something is wrong here. val is a pointer to u32.
> > corsairpsu_linear11_to_int(), however, returns an int.
> > The implementation of corsairpsu_linear11_to_int() suggests
> > that the value can be negative. Either it can be negative
> > and needs to be returned as such, or it can't and
> > corsairpsu_linear11_to_int() should only return unsigned
> > values.
> >
> > Also, this can overflow: corsairpsu_linear11_to_int()
> > can return a value larger that (MAXINT / 1000).
> >
> > > +	case PSU_CMD_TOTAL_WATTS:
> > > +		*val = (data[1] << 8) + data[0];
> > 
> > Same here.
> > 
> > > +		*val = corsairpsu_linear11_to_int(*val) * 1000000;
> > 
> > Same problems as above, and overflow is even more likely.
> 
> You are right, using int here is missleading. The values delivered through
> the LINEAR11 format can be negative, but the micro-controller delivers only
> positive values for the commands used. The biggest LINEAR11 value delivered
> by the micro-controller is about 1600 (1.6 kilo watts for the AX1600i, which
> the driver does not support). The other big value is the fan rpm value, which
> does not exceed 8000. So I'm not sure how to proceed here. Do I make a comment
> explaining this or do I go for the int/long? Using int would limit the uptime
> to, oh, 68 years. I guess going for the int/long will be okay.
> 

Just use long. FWIW, if you only want to handle unsigned values, the return
value (0 or positive) could be combined with the error (negative), and the
pointer would not be needed. I think it better to play safe and return the
value as long *, though.

> > > +			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, &tmp);
> > > +			break;
> > > +		case 1:
> > > +		case 2:
> > > +		case 3:
> > 
> > What is the problem with the following ?
> > 
> > 		case 1...3:
> >
> 
> Oh, this is a bit embarrassing. I never used (and saw) this switch case
> variant before. Well, you never stop learning...
> 
I have to admit that it is quite new for me as well, but I find it convenient.
And it is kind of odd tht it needs three dots (and it may need spaces before
and after the '...').

> Thank you for your patience, that were some tough lessons.

My pleasure.

Thanks,
Guenter
