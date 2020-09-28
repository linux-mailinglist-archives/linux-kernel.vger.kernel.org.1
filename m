Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40E27B7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgI1XSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:18:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgI1XSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:51 -0400
X-Greylist: delayed 5723 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 19:18:49 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B920DF0A8C;
        Mon, 28 Sep 2020 17:43:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=cKCCV4JvVtKZVo2OWfaysl1dwHc=; b=VCiLey
        7sFegHk1JI8eAUJdm3Pe2FLaOeZeFedpU8mzoPhBkJqpmtDkLarTjtCT7awxP94M
        ArVAPQWGhgBF7DC/zHrld4smaqaGQ86udavX3eOxcr82TXuCjF7WAvwctTp+W12N
        ygMlh3A0jXdtZ+5lJSezNZvhZHi77N14q99sQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0E1EF0A8B;
        Mon, 28 Sep 2020 17:43:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=CgOZQoxVv2I9ohh2CWrXtupYw1WiMqMLwgc7oQUtRkg=; b=TwI3tNfLUeCSwk0mgmH1tT7bumPQgaA/crFEEGy3MAr2zRuKqOkWTM4dbgaywZ9UDajnVg+BQ3ffv6OkjegU2jUiok7giZ+5LKKH9g2vcBai1aRbpP1glhFSWig2LAB/uhI65/YTQlQ1uuDW4svZhiYHMLwjRhv0Szcq+6cVZbA=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87BDFF0A8A;
        Mon, 28 Sep 2020 17:43:22 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 708D42DA0543;
        Mon, 28 Sep 2020 17:43:20 -0400 (EDT)
Date:   Mon, 28 Sep 2020 17:43:20 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Rong Chen <rong.a.chen@intel.com>
cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        gcc@gcc.gnu.org
Subject: Re: {standard input}:1174: Error: inappropriate arguments for opcode
 'mpydu'
In-Reply-To: <783f6c8f-1ef4-f5f6-9ac2-b2372c7f340d@intel.com>
Message-ID: <nycvar.YSQ.7.78.906.2009281705410.1581@knanqh.ubzr>
References: <202008300726.ynqzYKmk%lkp@intel.com> <nycvar.YSQ.7.78.906.2008292257360.1479@knanqh.ubzr> <783f6c8f-1ef4-f5f6-9ac2-b2372c7f340d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A1979A74-01D3-11EB-BDB7-F0EA2EB3C613-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Sep 2020, Rong Chen wrote:

> Hi Nicolas,
> 
> Thanks for the feedback, the error still remains with gcc 10.2.0:

I've created the simplest test case that can be. You won't believe it.

Test case:

$ cat test.c
unsigned int test(unsigned int x, unsigned long long y)
{
	y /= 0x20000000;
	if (x > 1)
		y *= x;
	return y;
}
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/0day/gcc-9.3.0-nolibc/arc-elf/libexec/gcc/arc-elf/9.3.0
$ ~/0day/gcc-9.3.0-nolibc/arc-elf/bin/arc-elf-gcc -mcpu=hs38 -mbig-endian -O2 -c test.c
/tmp/cc0GAomh.s: Assembler messages:
/tmp/cc0GAomh.s:21: Error: inappropriate arguments for opcode 'mpydu'

I know nothing about ARC. Please anyone take it over from here.


Nicolas
