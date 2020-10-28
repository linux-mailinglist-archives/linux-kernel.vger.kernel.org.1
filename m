Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B873029DC61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgJ2A34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:29:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:42395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbgJ2A3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603931354;
        bh=1x1pkj+ajXmsfrHufbFh9PGoA8v8ZYMZRPHOv6rHqKo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Sq3ghWn4LN0u/zAfvaprxjY97tlK2UqpCsHTtyjVC9oe65QwUkBPFQT2GhCJMUyh0
         x3Hlu462wFRhboMViEm/+0NefEjannONEUy7RuCoKw+qqZ2TEXccuEWI6GcnH1iQh8
         kj33/UsXCTo/IvaYSB+DP7xMjV9DOFPJriNj0u8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.58] ([92.116.189.175]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1krzLr0wEl-00XwjY; Wed, 28
 Oct 2020 15:54:36 +0100
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix serial port stall after resume
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200929193327.GA13987@ls3530.fritz.box>
 <20201008152103.GK26280@localhost>
 <1aefc37b-8976-efda-f397-2d9492b1260a@gmx.de>
 <20201027090043.GG4085@localhost>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <a2b84135-761b-6e9c-59d5-857bfa6d0281@gmx.de>
Date:   Wed, 28 Oct 2020 15:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027090043.GG4085@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G1UVVWCLE9kHZPkoEqVOqg+lkFWn4s8mCRYk3zd1H0DfGQuGTb2
 qsnnbZ9gGKqfcYrQzPRP3tHOeqkLEiF0HGvb2Y06GyVx1vrgZ4nDsyrhQpbdp58EQ4SzSH1
 yO2ZFNyczR4xn22I4wO5yABRfF/bvkzruJrtDQNy25sygll3N/LNkOPDPCm23H4R7BD6Elb
 1Jbwr/wHghgiKi/SYaNAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bgc06VPmeEc=:YsVGB4qGyFx7QY7Jzd0Alr
 KNZhQtLkgyyztzkK467Bmh7M+CO8rK2h9MHCmM3+vEgmbqVI4fnK/XIJexLZmlQWkcuu4AfG6
 l4UVbxHKiebgZJ75I8TlCOtjPqSlYlZ2ij80QnFJSkFIjee6j4OZwkb2o3F8tm4c28JMHR4GG
 pyvObOEmd1i9gm/fDFOi/CSNTvtLb3Iic9yxiRbK+rdkgYStJcmFnvsM49V0gIDrRMxLUTFRk
 1LhC1WUp34xCuxMYJwIqO3i/04eR8vuYlbZlJjY5MDU1SWkjsFz+LCxGo5nhXj9hqPAIZ/8Ah
 6pcUJ65rr50zszzKqrD5cPG9RLXmeNa57tw1qZw61V/RLnrUxo9zpOMEzZ+3zatz2LQZlY/kA
 DPEd2bNv3uTBhbId29f6mluKTQ+oLAOkrz5Z/xIM+nndNiZydUSYExNYmzZCVPRMMgQeDfIqH
 bCFGdPm7jchQb6LhoHxLgCdZ7PMYW5Z++tzLXHqrg40zLOBqtfqITFdhzqbwUCwmR7XQzF6ZZ
 KR0iBpUDhqqJ86GsCKE7SFjPRgdEpApYJBq1rct96LPP8qrWG1JdDK1/GYOEQNHjI8DE1TSwG
 ndTEiXoQAW1jRt1zuKUCgUdSz/B8EXgfxw+A+0DM9PGP+gOJiahXU0xhfN5m85SCeh8ZBS1yp
 hArP9hxSXnxKBHQc7uvfFYw/6SUurixYH0yK215gbNIA2pSXYXvMJcd6w5emZ8DtLkc68wwaW
 Vln6XkxyK6/bKNb1wXviIlkYjxgucEyngag+EKhOAcl8ruzv6+6MAJpxco/NE+vy/VMuDmq/t
 cCbtvCKcSrAXZjr4AbUXbaRUVfL3z+uouWde5h7ClFAIRMaH8sZozqr48hjcMpewIpMQnBfdv
 Sk/qqQFsZG+wkWRF8CXg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 10:00 AM, Johan Hovold wrote:
> On Thu, Oct 08, 2020 at 08:16:02PM +0200, Helge Deller wrote:
>> On 10/8/20 5:21 PM, Johan Hovold wrote:
>>> On Tue, Sep 29, 2020 at 09:33:27PM +0200, Helge Deller wrote:
>>>> With a 4-port serial USB HUB with FT232BM chips the serial ports stop
>>>> working after a software suspend/resume cycle.
>>>> Rewriting the latency timer during the resume phase fixes it.
>
>>>> +static int ftdi_reset_resume(struct usb_serial *serial)
>>>> +{
>>>> +	struct usb_serial_port *port =3D serial->port[0];
>>>> +
>>>> +	if (tty_port_initialized(&port->port))
>>>> +		write_latency_timer(port);
>>>
>>> Why are you only doing this for open ports?
>>
>> I more or less copied it from another driver....
>>
>>>> +
>>>> +	return usb_serial_generic_resume(serial);
>>>> +}
>>>
>>> And if the device has been reset there may need to reconfigured the
>>> termios settings for open ports.
>>>
>>> Could you expand a bit on what the problem is here?
>>
>> My testcase is pretty simple:
>> 1. I use e.g. "minicom -D /dev/ttyUSB2". Serial connection works.
>> 2. I exit minicom.
>> 3. I suspend the workstation: "systemctl suspend"
>> 4. I wake up the machine and wait a few seconds.
>> 5. I start "minicom -D /dev/ttyUSB2" again. No transfers on the serial =
port.
>>
>> With my patch the minicom serial communications does work.
>> Another way to wake up the connection is to rmmod the driver and
>> insmod it again.
>
> Weird indeed. If you exit minicom before suspend and no other process is
> keeping the port open, then that write_latency_timer() above would never
> be executed.
>
> Could you enable some debugging and provide a dmesg log from a test
> cycle (open/close minicom, suspend/resume, open minicom)?
>
> 	echo file usb-serial.c +p > /sys/kernel/debug/dynamic_debug/control

I enabled the debugging and tried a few times, but somehow I can not
reproduce the issue any longer.

So, please drop my patch for now.

Thanks!
Helge
