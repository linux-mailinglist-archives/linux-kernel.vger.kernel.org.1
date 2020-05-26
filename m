Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C91B268D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgDUMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 08:42:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgDUMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587472943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i5oQF8NSSIrLs5uFrL1LNyP8q4PvEuugILa5jqu73o=;
        b=VDWLLEdz+8vZQLtdvTUegcSHhpr5V4I0jaiCcI90pChq3leIb9LS1c9S8H9llEaKScLBub
        UTZgCLQy1QKu2RH0AEElFcvl19JsyYQ7rzb8tnrrd54Tl+iZ4nAPmtlk0vgOCCF4akal+2
        Aua2cvNS1YO864ZCVRwwEZ0uJJWIjow=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-N2kHrFjAMuGDsWmMTivBaA-1; Tue, 21 Apr 2020 08:42:20 -0400
X-MC-Unique: N2kHrFjAMuGDsWmMTivBaA-1
Received: by mail-wr1-f69.google.com with SMTP id g7so6527603wrw.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0i5oQF8NSSIrLs5uFrL1LNyP8q4PvEuugILa5jqu73o=;
        b=cWidu1yfTGu5EYCa+p2vLg2/Syta59UkA0JCyo4g7AUfn/COyYVbsvnFSRw1kCHkN3
         ZwLqr8MGUhz9v6P62jvfwRhVtU4LaS0wdKLKZ6PuebCIEaZSz0B+Eo5Ca6ZA4kw7o1Da
         tdwmgeuUSF76gR524OBLQ/FxOXO8kt7dzJ5eESPMPefC+XFxRinVb9lMhs9j3SDtG8kV
         +dyXKLRr8S9eJiSjalJNYzl4sAHW4F9Wtsomy5bPArnHp3RzmlmB5rd/xtgWuUXGmNel
         Q7BODymaRkkcA8R2yN+E+TsY8gTwMf9ClfS4fN2qDGexoT5DUgY2cUknVJhhqQKWVe3U
         vyBg==
X-Gm-Message-State: AGi0PubTx1HACMS0XW1WIW/elfanxnD0H4tHgWo0aYePif2+kTW8iDtp
        +JyZz2M2BzrkaEQx7V1qlx3suBUliLD5ZShWdPuf2OsxcDizfjRjn2yD9gUaBj1SJrL6gLaGkZ7
        jHB7TPXxp3VR5IbIH4hNd7Eth
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr5065365wml.55.1587472939152;
        Tue, 21 Apr 2020 05:42:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHSJEQpJdj2DbcpOi0JqH5gRJxDD5uXNrWTxXRPlLie2+9zUl7DidZ05yE4HjxiMTAphOppQ==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr5065347wml.55.1587472938980;
        Tue, 21 Apr 2020 05:42:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k133sm3603837wma.0.2020.04.21.05.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 05:42:18 -0700 (PDT)
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, yuyufen@huawei.com,
        tj@kernel.org, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz>
 <20200417130135.GB5053@lst.de>
 <e02b7cdc-f29a-916c-d923-224a1b312485@redhat.com>
 <20200420115856.GA12115@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <804e7412-0172-555f-69a9-7937d086a056@redhat.com>
Date:   Tue, 21 Apr 2020 14:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420115856.GA12115@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/20 1:58 PM, Christoph Hellwig wrote:
> On Mon, Apr 20, 2020 at 01:41:57PM +0200, Hans de Goede wrote:
>> AFAICT for vboxsf the bdi-name can be anything as long as it is unique, hence
>> the "vboxsf-" prefix to make this unique vs other block-devices and the
>> ".%d" postfix is necessary because the same export can be mounted multiple
>> times (without using bind mounts), see:
>> https://github.com/jwrdegoede/vboxsf/issues/3
> 
> Shouldn't vboxsf switch to get_tree_single instead of get_tree_nodev?
> Having two independent dentry trees for a single actual file system
> can be pretty dangerous.

That is a good point I will look into this.

> 
>>
>> The presence of the source inside the bdi-name is only for informational
>> purposes really, so truncating that should be fine, maybe switch to:
>>
>> "vboxsf%d-%s" as format string and swap the sbi->bdi_id and fc->source
>> in the args, then if we truncate anything it will be the source (which
>> as said is only there for informational purposes) and the name will
>> still be guaranteed to be unique.
> 
> Can we just switch to vboxsf%d where %d іs a simple monotonically
> incrementing count?  That is what various other file systems (e.g. ceph)
> do.

Yes that is fine with me.

Regards,

Hans

