Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4A272D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgIUQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgIUQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:37:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA926C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:37:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so13517446wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZX0lVSW/BkEY5EryFzi+/GuKlznQU9YGzQJgrOT6C4=;
        b=iBQJfW+PbQ6dwx/Cp+3UtA7/VPz72PX7opUnQ6BephjRS45wwN6DC4an23bNi+ZkLp
         KY8NYSomNL0yvk5PYd+YcVM7qPjf1OQ6F4sN8xMMopxX7WzgQaWRIPA7U6CnnxWuinYF
         PuXLhzUkRHSAXdoCZMswlHSFHTS9CnTNYFcOtfvDCGLnGoVL99ZstlVaAX9TJwGjwuPb
         LC4hyQf2iuSV7MpYla1zP2MM9RTgkJbmD+maHoMBcj9Gvv6XUxiz+5T0eBT0ShHHO7Oq
         Kvlo1RBZFyMNune7QwzqMAZ5n1E8n3ghIY3wcBR1on7ovqDkZ14X8JMBwh0TfejPapaJ
         pBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZX0lVSW/BkEY5EryFzi+/GuKlznQU9YGzQJgrOT6C4=;
        b=SrcSUhyT3qhlOYUJ06u0J7PTt/S3xGCrJstVQHK7AAtQ7uQm6YDBZOqlZ5ABkNCttY
         wf5wfWpw7ZBoVZd+TLgBO42uTZCMn9YRfpYl2HJoeKvuvblc4fFeO1p6NZPPP2bn2aVJ
         613g9XFzjDyEBiD+gf0ojjnk0SMGTouMa+Z3USdyl1CrDNLySgYc1ZKGsZRhP9qRJHlP
         Zv1CoOHOmIPvoneEAKl3tpMVGHcFq7Myi7QOldUKxhMY3FS+UmeS6E4WobyjBBf4fXcw
         efJr1LYorp/Bpc1Z7np/ukBLSrnncmkauJUoaB5WjG1KT81pBa/3woTkkViPkuxRMUkk
         P84g==
X-Gm-Message-State: AOAM531AkVUE4vVTNupJK3sQLweFynTE3nkDbuZfFgo6auzs7g3UbxfF
        gyqMkTH4zCzmbw4u/L7KhEw=
X-Google-Smtp-Source: ABdhPJyp/emP4vnjJL52ic60TOBn1bsoBW6KlikgArO8roRt4MwSrsouq5KTXeDvMPwYcqBCSFtfQw==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr606109wrg.131.1600706239370;
        Mon, 21 Sep 2020 09:37:19 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id c16sm22948533wrx.31.2020.09.21.09.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:37:18 -0700 (PDT)
Subject: Re: [PATCH v3 9/9] drm/mediatek: reduce clear event
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        HS Liao <hs.liao@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
 <CAAOTY_-BKW9jbGD5-Un=xagRWizOXaBrvvfdQV7TyzhYWuS8Ag@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a2636ee7-f326-e709-2a50-03253bc0b6c2@gmail.com>
Date:   Mon, 21 Sep 2020 18:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-BKW9jbGD5-Un=xagRWizOXaBrvvfdQV7TyzhYWuS8Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 01:01, Chun-Kuang Hu wrote:
> Hi, Dennis:
> 
> Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com> 於 2020年7月7日 週二 下午11:47寫道：
>>
>> No need to clear event again since event always clear before wait.
>> This fix depend on patch:
>>    "soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api"
> 
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 

Pushed now to v5.9-next/soc

Thanks!

>>
>> Fixes: 2f965be7f9008 ("drm/mediatek: apply CMDQ control flow")
>> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>> index c84e7a14d4a8..ba6cf956b239 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>> @@ -490,7 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
>>                  mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
>>                  cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
>>                  cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
>> -               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, true);
>> +               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
>>                  mtk_crtc_ddp_config(crtc, cmdq_handle);
>>                  cmdq_pkt_finalize(cmdq_handle);
>>                  cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
>> --
>> 1.7.9.5
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
